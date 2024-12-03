import 'package:cat_tinder/auth/bloc/form_bloc.dart';
import 'package:cat_tinder/auth/bloc/form_event.dart';
import 'package:cat_tinder/auth/bloc/form_state.dart';
import 'package:cat_tinder/helper_pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthTab extends StatelessWidget {
  const AuthTab({super.key, required this.title, required this.buttonText, required this.isSignIn});

  final String title;
  final String buttonText;
  final bool isSignIn;
  
  final SizedBox spaceBetween = const SizedBox(height: 16);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthFormBloc, AuthFormState>(builder: (context, state) {
      final authContext = context.read<AuthFormBloc>();

      if (state.isLoading) {
        return LoadingPage();
      }

      if (state.isSuccessful) {
        // TODO navigate to the next page
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 24.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Form(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // the Email input field
                      TextFormField(
                        autofillHints: const [AutofillHints.email],
                        initialValue: state.email,
                        onChanged: (value) => authContext.add(EmailChanged(value)),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'address@example.com',
                          errorText: state.emailError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                        keyboardType: TextInputType.emailAddress,
                        validator: (_) => state.emailError,
                      ),
                      spaceBetween,
                      // the Password input field
                      TextFormField(
                        onChanged: (value) => authContext.add(PasswordChanged(value)),
                        initialValue: state.password,
                        autofillHints: const [AutofillHints.password],
                        obscureText: !state.showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          errorText: state.passwordError == '' ? null : state.passwordError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          // the password visibility toggle
                          suffixIcon: InkWell(
                            onTap: () => authContext.add(TogglePasswordVisibility()),
                            focusNode: FocusNode(skipTraversal: true),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 16.0),
                              child: Icon(
                                state.showPassword ? Icons.visibility : Icons.visibility_off,
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (_) => state.passwordError == '' ? null : state.passwordError,
                      ),
                      spaceBetween,

                      // the Sign in button
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () => authContext.add(FormSubmitted(isSignIn: isSignIn)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            child: Text(buttonText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
