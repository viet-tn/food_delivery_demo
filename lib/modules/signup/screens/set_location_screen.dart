import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/ui/listen_error.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/location_selector.dart';
import '../widgets/sign_up_flow_screen.dart';

class SetLocationScreen extends StatelessWidget {
  const SetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenError<SignUpCubit>(
      child: SignUpFlowScreen(
        onNextPressed: () async {
          context.read<SignUpCubit>().onSetLocationComplete();
          await context.read<SignUpCubit>().onSignUpComplete();
        },
        title: 'Set Your Location ',
        subTitle:
            'This data will be displayed in your account profile for security',
        child: const LocationSelector(),
      ),
    );
  }
}
