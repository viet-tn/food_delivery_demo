import 'package:flutter/material.dart';

import '../constants/ui/colors.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../constants/ui/ui_parameters.dart';
import '../gen/assets.gen.dart';
import '../utils/ui/card.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'Testimonials',
            style: FTextStyles.heading4,
          ),
        ),
        ...List.generate(
          3,
          (_) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: TestimonialCard(),
          ),
        ),
      ],
    );
  }
}

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox.square(
            dimension: 75.0,
            child: ClipRRect(
              borderRadius: Ui.borderRadius,
              child: Placeholder(),
            ),
          ),
          gapW16,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dianne Russell',
                          style: FTextStyles.heading5,
                        ),
                        Text(
                          '12 April 2021',
                          style: FTextStyles.label.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: FColors.lightGreen.withOpacity(.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox.square(
                            dimension: 20.0,
                            child: Image.asset(Assets.icons.starFull.path),
                          ),
                          gapW4,
                          Text(
                            '5',
                            style: FTextStyles.heading3.copyWith(
                              color: FColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                gapH12,
                Text(
                  'This Is great, So delicious! You Must Here, With Your family . . ',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.body.copyWith(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
