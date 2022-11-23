import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../modules/cubit/app_cubit.dart';
import '../dialogs/alert_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog<bool>(
          context: context,
          builder: (context) => const FAlertDialog(title: 'Confirm Logout'),
        ).then((value) {
          if (value == true) {
            context
                .read<AppCubit>()
                .signOut()
                .then((_) => FCoordinator.goNamed(Routes.logIn.name));
          }
        });
      },
      icon: const Icon(
        Icons.logout_outlined,
        color: Colors.black54,
        size: 32.0,
      ),
    );
  }
}
