import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final titleStyle = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
  );

  final colors = [Colors.deepPurple, Colors.red, Colors.orange];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final primaryButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Card.outlined(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              // Content of the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // The first line with the icon
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      GradientText(
                        'Cat Tinder',
                        style: titleStyle,
                        colors: colors,
                      ),
                      if (width > 600)
                        Padding(
                          padding: const EdgeInsets.only(left: 110, top: 10),
                          child:
                              Image.asset('assets/images/paw.png', width: 100),
                        )
                    ],
                  ),
                  Text('An app to you find your purrfect match to adopt!'),

                  // The buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is SignedInUser) {
                          return ElevatedButton(
                            style: primaryButtonStyle,
                            onPressed: () => context.go('/rate'),
                            child: Text('Rate Cats'),
                          );
                        }

                        return Wrap(
                          spacing: 10,
                          children: [
                            ElevatedButton(
                              style: primaryButtonStyle,
                              onPressed: () =>
                                  context.go('/login', extra: false),
                              child: Text('Login'),
                            ),
                            ElevatedButton(
                              // the extra param says to open the signup page
                              onPressed: () =>
                                  context.go('/login', extra: true),
                              child: Text('Sign Up'),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('© 2024 Cat Tinder',
              style: Theme.of(context).textTheme.labelSmall),
        ),
      ),
    );
  }
}
