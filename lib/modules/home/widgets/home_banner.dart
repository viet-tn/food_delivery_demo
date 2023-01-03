import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            height: 180,
            autoPlay: true,
            viewportFraction: 0.92,
            onPageChanged: (index, reason) {
              setState(() {
                this.index = index;
              });
            },
          ),
          items: banners.map((path) {
            return ClipRRect(
              borderRadius: Ui.borderRadius,
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
        gapH8,
        AnimatedSmoothIndicator(
          activeIndex: index,
          count: banners.length,
          effect: const WormEffect(
            dotHeight: 10.0,
            dotWidth: 10.0,
            activeDotColor: FColors.green,
          ),
        ),
      ],
    );
  }
}
