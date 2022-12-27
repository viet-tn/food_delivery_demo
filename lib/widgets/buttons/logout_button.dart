import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dialogs/dialog.dart';

import '../../config/routes/coordinator.dart';
import '../../modules/cubits/app/app_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => FAlertDialog(
            onYesPressed: () {
              Navigator.pop(context);
              context
                  .read<AppCubit>()
                  .signOut()
                  .then((_) => FCoordinator.goNamed(Routes.logIn.name));
            },
            title: 'Confirm Logout',
          ),
        );
      },
      icon: const Icon(
        Icons.logout_outlined,
        color: Colors.black54,
        size: 32.0,
      ),
    );
  }
}
