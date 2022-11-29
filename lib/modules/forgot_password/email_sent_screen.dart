import 'dart:developer';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/buttons/text_button.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FScaffold(
        body: SizedBox.expand(
          child: Padding(
            padding: Ui.screenPadding,
            child: Column(
              children: [
                gapH64,
                Image.asset(Assets.icons.email.path),
                gapH32,
                const Text(
                  'Check your mail',
                  style: FTextStyles.heading1,
                ),
                gapH12,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'We have sent a password recover instructions to your email.',
                    textAlign: TextAlign.center,
                    style: FTextStyles.body.copyWith(color: Colors.black54),
                  ),
                ),
                gapH32,
                GradientButton(
                  width: 260.0,
                  onPressed: _onOpenMailAppPressed,
                  child: const Text(
                    'Open email app',
                    style: FTextStyles.button,
                  ),
                ),
                gapH20,
                TextButton(
                  onPressed: () {
                    FCoordinator.goNamed(Routes.logIn.name);
                  },
                  child: Text(
                    'Skip, I\'ll confirm later',
                    style: FTextStyles.body.copyWith(color: Colors.black54),
                  ),
                ),
                const Spacer(),
                const Text(
                    'Did not receive the email? Check your spam filter,'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('or'),
                    FTextButton(
                      text: 'try another email address',
                      onPressed: () {
                        FCoordinator.goNamed(Routes.forgotPassword.name);
                      },
                    )
                  ],
                ),
                gapH32,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onOpenMailAppPressed() {
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      intent.launch().catchError((e) {
        log(e.runtimeType.toString());
      });
    } else if (Platform.isIOS) {
      launchUrlString("message://").catchError((e) {});
    }
  }
}
