import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/cubit.dart';
import '../../base/state.dart';
import 'snack_bar.dart';

class ListenError<C extends FCubit> extends StatelessWidget {
  const ListenError({
    super.key,
    required this.child,
    this.bloc,
  });

  final Widget child;
  final C? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, FState>(
      bloc: bloc,
      listenWhen: (_, current) => current.status.hasError,
      listener: (_, state) {
        log(state.errorMessage ?? '');
        FSnackBar.showSnackBar(
          'On Snap!',
          state.errorMessage ?? 'An unknown error occurred!',
        );
      },
      child: child,
    );
  }
}
