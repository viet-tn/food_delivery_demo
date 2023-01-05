import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({
    super.key,
    required this.paths,
    required this.texts,
  });

  final List<String> paths;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    if (paths.length != texts.length) return const Text('Error');
    return Row(
      children: List.generate(
        paths.length,
        (index) => Row(
          children: [
            Row(
              children: [
                _icon(paths[index]),
                gapW4,
                Text(
                  texts[index],
                  style: FTextStyles.body.copyWith(
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            gapW20,
          ],
        ),
      ),
    );
  }

  Widget _icon(String path) {
    return SizedBox.square(
      dimension: 22.0,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }
}
