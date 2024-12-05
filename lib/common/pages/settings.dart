import 'package:cat_tinder/auth/bloc/auth_bloc.dart';
import 'package:cat_tinder/auth/bloc/auth_event.dart';
import 'package:cat_tinder/common/bloc/theme_mode_cubit.dart';
import 'package:cat_tinder/rate/widgets/menu_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          ListTile(
            title: Text('Licenses'),
            subtitle: Text('View licenses for libraries used in this app'),
            enabled: true,
            onTap: () => showLicensePage(context: context),
            trailing: Icon(Icons.description),
          ),
          BlocBuilder<ThemeModeCubit, ThemeMode>(
            builder: (context, state) {
              return ListTile(
                title: Text('Change theme'),
                subtitle: Text('Current: ${state.toString().split('.').last}'),
                enabled: true,
                onTap: () => context.read<ThemeModeCubit>().step(),
                trailing: Icon(_getThemeModeIcon(state)),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Sign out'),
            subtitle: Text('Sign out of the app'),
            enabled: true,
            onTap: () => context.read<AuthBloc>().add((SignOut())), 
            trailing: Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: MenuNavigation(),
    );
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_high;
      case ThemeMode.dark:
        return Icons.brightness_3;
    }
  }
}
