import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/textfield/text_field.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField(
      {super.key, required this.textEditingController, this.onSubmitted});

  final TextEditingController textEditingController;
  final void Function(String content)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12.0,
        0.0,
        12.0,
        12.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: FTextField(
              onSubmitted: _onSendMessages,
              controller: textEditingController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
            ),
          ),
          gapW4,
          IconButton(
            onPressed: () => _onSendMessages(textEditingController.text),
            padding: const EdgeInsets.all(15.0),
            icon: SizedBox.square(
              dimension: 25.0,
              child: Image.asset(Assets.icons.send.path),
            ),
          ),
        ],
      ),
    );
  }

  void _onSendMessages(String content) {
    content = content.trim();
    if (content.isEmpty) return;
    onSubmitted?.call(content);
    textEditingController.clear();
  }
}
