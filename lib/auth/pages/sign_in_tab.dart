import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/form_cubit.dart';
import 'package:cat_tinder/auth/bloc/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInTab extends StatelessWidget {
  SignInTab({super.key});

  final spaceBetween = const SizedBox(height: 16);
  final formValidatorCubit = FormCubit();

  // TODO: Turn the Cubit into a Bloc and add the necessary logic!!!

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 24.0),
              child: Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            BlocBuilder<FormCubit, AuthFormState>(
              builder: (context, state) {

                return Form(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // the Email input field
                        TextFormField(
                          controller: cubit.emailController,
                          autofillHints: const [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            errorText: state.emailError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => cubit.isEmailValid(value ?? ''),
                        ),
                        spaceBetween,
                        // the Password input field  
                        TextFormField(
                          controller: cubit.passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: !state.passwordVisibility,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            errorText: state.passwordError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            // the password visibility toggle
                            suffixIcon: InkWell(
                              onTap: () => cubit.togglePasswordVisibility(),
                              focusNode: FocusNode(skipTraversal: true),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(end: 16.0),
                                child: Icon(
                                  state.passwordVisibility ? Icons.visibility : Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => cubit.isEmailValid(value ?? ''),
                        ),
                        spaceBetween,
                        
                        // the Sign in button
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => cubit.onSubmit(context.read<AuthBloc>().authRepository),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text('Sign In'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
