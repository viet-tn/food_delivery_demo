import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../gen/assets.gen.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({
    super.key,
    required this.name,
    required this.email,
    this.onEditPressed,
  });

  final String name;
  final String email;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: FTextStyles.heading1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
              onPressed: onEditPressed,
              icon: SizedBox.square(
                dimension: 20.0,
                child: Image.asset(
                  Assets.icons.edit.path,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
        gapH12,
        Text(
          email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: FTextStyles.body.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
