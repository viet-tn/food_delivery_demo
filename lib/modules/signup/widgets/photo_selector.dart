import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/ui/drop_shadow.dart';

class PhotoSelector extends StatelessWidget {
  const PhotoSelector({
    super.key,
    required this.onImgSelected,
  });

  final void Function(String? imgPath) onImgSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UploadPhotoButton(
          onTap: () async {
            final file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            onImgSelected(file?.path);
          },
          title: 'From Gallery',
          iconPath: Assets.icons.gallery.path,
        ),
        gapH24,
        UploadPhotoButton(
          onTap: () async {
            final file =
                await ImagePicker().pickImage(source: ImageSource.camera);
            onImgSelected(file?.path);
          },
          title: 'Take Photo',
          iconPath: Assets.icons.camera.path,
        ),
      ],
    );
  }
}

class UploadPhotoButton extends StatelessWidget {
  const UploadPhotoButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      elevation: 20.0,
      child: Ink(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(borderRadius: Ui.borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: Ui.borderRadius,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath),
              gapH8,
              Text(
                title,
                style: FTextStyles.button.copyWith(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
