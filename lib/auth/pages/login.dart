import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:cat_tinder/auth/bloc/form_bloc.dart';
import 'package:cat_tinder/auth/pages/auth_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.openSignup = false});

  final bool openSignup;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: openSignup ? 1 : 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign In'),
              Tab(text: 'Sign Up'),
            ],
          ),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final AuthBloc authBloc = context.read<AuthBloc>();

            return TabBarView(
              children: [
                BlocProvider(
                  create: (context) => AuthFormBloc(authBloc),
                  child: AuthTab(
                    title: 'Welcome back!',
                    buttonText: 'Sign in',
                    isSignIn: true,
                  ),
                ),
                BlocProvider(
                  create: (context) => AuthFormBloc(authBloc),
                  child: AuthTab(
                    title: 'Sign up!',
                    buttonText: 'Sign up',
                    isSignIn: false,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
