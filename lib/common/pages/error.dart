import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  // ignore: avoid_init_to_null
  const ErrorPage({super.key, String? title, String? message, Function? action = null}) : 
  _title = title ?? 'Something went wrong', 
  _message = message, 
  _action = action;

  final String _title;
  final String? _message;
  final Function? _action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_title, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 15),
            if (_message != null)
              Text('Error message: AY$_message'),
            if (_action != null)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () => {_action.call()},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Try again'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
