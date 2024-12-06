import 'package:cat_tinder/common/utils/app_router.dart';
import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/common/bloc/theme_mode_cubit.dart';
import 'package:cat_tinder/common/utils/app_theme.dart';
import 'package:cat_tinder/firebase_options.dart';
import 'package:cat_tinder/rate/bloc/rate_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For debugging
  // Bloc.observer = AppBlocObserver();

  // Blocs
  final authBloc = AuthBloc(FlutterAuthRepository());

  MultiBlocProvider appWithProviders = MultiBlocProvider(
    providers: [
      BlocProvider.value(value: authBloc),
      BlocProvider(create: (context) => ThemeModeCubit()),
      BlocProvider(create: (context) => RateBloc(authBloc)),
    ],
    child: MyApp(
      appRouter: AppRouter(),
      appTheme: AppTheme(),
    ),
  );

  runApp(appWithProviders);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter, required this.appTheme});

  final AppTheme appTheme;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // To refresh the router for redirect if needed
        appRouter.router.refresh();
      },
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Cat Tinder',
            theme: appTheme.light,
            darkTheme: appTheme.dark,
            themeMode: state,
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
