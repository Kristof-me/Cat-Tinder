import 'package:cat_tinder/auth/auth_repository.dart';
import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/auth/pages/Login.dart';
import 'package:cat_tinder/dev/app_bloc_observer.dart';
import 'package:cat_tinder/firebase_options.dart';
import 'package:cat_tinder/common/pages/error.dart';
import 'package:cat_tinder/common/pages/home.dart';
import 'package:cat_tinder/rate/pages/liked.dart';
import 'package:cat_tinder/rate/pages/rate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For debugging
  Bloc.observer = AppBlocObserver();

  final authBloc = AuthBloc(FlutterAuthRepository());

  MultiBlocProvider appWithProviders = MultiBlocProvider(
    providers: [
      BlocProvider.value(value: authBloc),
      // TODO add blocs here
    ],
    child: MyApp(),
  );

  runApp(appWithProviders);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorColor: Colors.orangeAccent,
    ),
    // TODO add more theme options here
  );

  

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/',  builder: (context, state) => HomePage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage(openSignup: (state.extra ?? false) as bool)),
      GoRoute(path: '/signup', builder: (context, state) => LoginPage(openSignup: true)), // just in case for web users
      
      // TODO add route for: /settings
      // TODO add route for: /chat
      GoRoute(path: '/rate', pageBuilder: (context, state) => fadeTransitionPage(context, state, RatePage())),
      GoRoute(path: '/liked', pageBuilder: (context, state) => fadeTransitionPage(context, state, LikedPage())),
      // TODO add route for: /dislikes

      GoRoute(
        path: '/error',
        builder: (context, state) {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;

          String? title = extra['title'] as String?;
          String? message = extra['message'] as String?;
          Function? action = extra['action'] as Function?;

          return ErrorPage(title: title, message: message, action: action);
        }
      ),
    ],
    redirect: (context, state) {
      final AuthState authState = context.read<AuthBloc>().state;
      const List<String> noAuthPaths = ['/login', '/signup'];
      final String path = state.fullPath ?? state.uri.toString();

      if (authState is NoUser && !noAuthPaths.contains(path) && path != '/') {
        return '/login';
      }

      if (authState is SignedInUser && noAuthPaths.contains(path)) {
        return '/rate';
      }

      return path;
    }
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // To refresh the router for redirect if needed
        _router.refresh();
      },
      child: MaterialApp.router(
        title: 'Cat Tinder',
        theme: _appTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  static CustomTransitionPage fadeTransitionPage(context, state, page) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}