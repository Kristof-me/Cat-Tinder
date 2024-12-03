import 'package:cat_tinder/auth/pages/sign_in_tab.dart';
import 'package:cat_tinder/auth/pages/sign_up_tab.dart';
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
        body: TabBarView(
          children: [
            SignInTab(),
            SignUpTab(),
          ],
        ),
      ),
    );
  }
}
