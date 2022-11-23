import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/state.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/ui/loading_screen.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/buttons/back_button.dart';
import '../../../widgets/buttons/gradient_button.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpFlowScreen extends StatelessWidget {
  const SignUpFlowScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
    required this.onNextPressed,
    this.showBackButton = true,
  });

  final String title;
  final String subTitle;
  final Widget child;
  final VoidCallback onNextPressed;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, ScreenStatus>(
      selector: (state) => state.status,
      builder: (_, state) {
        return LoadingScreen(
          isLoading: state.isLoading,
          child: FScaffold(
            body: SingleChildScrollView(
              padding: Ui.screenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showBackButton ? const FBackButton() : const SizedBox(),
                  gapH16,
                  Text(
                    title,
                    style: FTextStyles.heading2,
                  ),
                  gapH32,
                  Text(
                    subTitle,
                    style: FTextStyles.label,
                  ),
                  gapH32,
                  child,
                ],
              ),
            ),
            centerBottomButton: GradientButton(
              onPresssed: onNextPressed,
              child: const Text(
                'Next',
                style: FTextStyles.button,
              ),
            ),
          ),
        );
      },
    );
  }
}
