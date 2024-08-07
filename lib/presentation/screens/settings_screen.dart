import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:toastification/toastification.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserFailed) {
              toastMessage(
                  context: context,
                  description: state.error,
                  type: ToastificationType.error);
            } else if (state is AuthUserSuccess) {
              // context.go('/');
              toastMessage(
                context: context,
                description: 'User Success Logout',
                type: ToastificationType.success,
              );
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthUserLogout());
                },
                child: Text('Logout'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
