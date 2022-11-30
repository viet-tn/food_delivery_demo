import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../signup/widgets/photo_selector.dart';

class ChangeAvatar extends StatelessWidget {
  const ChangeAvatar({
    super.key,
    required this.image,
    this.onImageChanged,
  });

  final Widget image;
  final void Function(String? imgUrl)? onImageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 150.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: 150.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000.0),
              child: image,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          height: 320.0,
                          padding: const EdgeInsets.all(20.0),
                          margin: const EdgeInsets.all(70.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: Ui.borderRadius,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Change photo',
                                style: FTextStyles.heading3,
                              ),
                              gapH12,
                              PhotoSelector(
                                onImgSelected: (imgPath) {
                                  onImageChanged?.call(imgPath);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(150.0),
              ),
            ),
          ),
          Positioned(
            right: 5.0,
            bottom: 5.0,
            child: Container(
              height: 35.0,
              width: 35.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  color: FColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
