import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/auth_bloc/auth_bloc.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:pos/router/named_route.dart';
import 'package:toastification/toastification.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Profile',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUserFailed) {
                toastMessage(
                    context: context,
                    description: state.error,
                    type: ToastificationType.error);
              } else if (state is AuthUserSuccess) {
                context.go(NamedRoute.routeOnBoarding);
                toastMessage(
                  context: context,
                  description: 'User Success Logout',
                  type: ToastificationType.success,
                );
              }
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    children: [
                      const CircleAvatar(radius: 60),
                      const SizedBox(height: 16),
                      Text(
                        'Faric Andrevano',
                        style: bodyL.copyWith(
                          fontWeight: bold,
                          color: neutral90,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Admin',
                        style: bodyL.copyWith(
                          fontWeight: bold,
                          color: neutral90,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: neutral20,
                  height: 2,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    children: [
                      const ListSettings(
                        leading: 'assets/icons/icon_settings_user.png',
                        title: 'General Information',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.5),
                        child: Divider(height: 2, color: neutral20),
                      ),
                      const ListSettings(
                        leading: 'assets/icons/icon_settings_account.png',
                        title: 'Account',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.5),
                        child: Divider(height: 2, color: neutral20),
                      ),
                      const ListSettings(
                        leading: 'assets/icons/icon_settings_store.png',
                        title: 'Outlet Placement History',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthUserLogout());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      foregroundColor: neutral90,
                      backgroundColor: neutral20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    label: Text(
                      'Logout',
                      style: bodyL.copyWith(
                        fontWeight: semiBold,
                        color: neutral90,
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings({super.key, required this.leading, required this.title});
  final String leading, title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        leading,
        height: 24,
      ),
      title: Text(
        title,
        style: bodyL.copyWith(
          fontWeight: medium,
          color: neutral90,
        ),
      ),
    );
  }
}
