import 'package:cat_tinder/common/pages/settings.dart';
import 'package:cat_tinder/rate/pages/disliked.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/auth/pages/Login.dart';
import 'package:cat_tinder/common/pages/error.dart';
import 'package:cat_tinder/common/pages/home.dart';
import 'package:cat_tinder/rate/pages/liked.dart';
import 'package:cat_tinder/rate/pages/rate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/',  builder: (context, state) => HomePage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage(openSignup: (state.extra ?? false) as bool)),
      GoRoute(path: '/signup', builder: (context, state) => LoginPage(openSignup: true)), // just in case for web users
      
      GoRoute(path: '/rate', pageBuilder: (context, state) => _fadeTransitionPage(context, state, RatePage())),
      GoRoute(path: '/liked', pageBuilder: (context, state) => _fadeTransitionPage(context, state, LikedPage())),
      GoRoute(path: '/disliked', pageBuilder: (context, state) => _fadeTransitionPage(context, state, DislikedPage())),

      GoRoute(path: '/settings', pageBuilder: (context, state) => _fadeTransitionPage(context, state, SettingsPage())),
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

  static CustomTransitionPage _fadeTransitionPage(context, state, page) {
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
