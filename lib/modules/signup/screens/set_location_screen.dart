import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/coordinator.dart';
import '../../../repositories/users/coordinate.dart';
import '../../../utils/ui/listen_error.dart';
import '../../../utils/ui/loading_screen.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/location_selector.dart';
import '../widgets/sign_up_flow_screen.dart';

class SetLocationScreen extends StatelessWidget {
  const SetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return LoadingScreen(
          isLoading: state.status.isLoading,
          child: ListenError<SignUpCubit>(
            child: SignUpFlowScreen(
              onNextPressed: () async {
                final isSuccess =
                    context.read<SignUpCubit>().onSetLocationComplete();
                if (isSuccess) {
                  context.read<SignUpCubit>().onSignUpComplete();
                }
              },
              title: 'Set Your Location ',
              subTitle:
                  'This data will be displayed in your account profile for security',
              child: BlocSelector<SignUpCubit, SignUpState, List<Coordinate>>(
                selector: (state) {
                  return state.user.coordinates;
                },
                builder: (context, state) {
                  return LocationSelector(
                    onSetLocationPressed: (latitude, longitude) {
                      FCoordinator.showMapScreen(
                        latitude,
                        longitude,
                        isSignUp: true,
                      );
                    },
                    address: state.isEmpty ? null : state[0].address,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
