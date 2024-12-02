import 'package:cat_tinder/dev/AppBlocObserver.dart';
import 'package:cat_tinder/firebase_options.dart';
import 'package:cat_tinder/helper_pages/error.dart';
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

  MultiBlocProvider appWithProviders = MultiBlocProvider(
    providers: [
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
    // TODO add more theme options here
  );

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',  
        builder: (context, state) => Scaffold(body: Text('Hello world'))
      ),
      
      // TODO add route for: /login-register
      // TODO add route for: /settings
      // TODO add route for: /chat
      // TODO add route for: /rate
      // TODO add route for: /likes
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
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cat Tinder',
      theme: _appTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}