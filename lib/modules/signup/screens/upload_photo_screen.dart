import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/ui/snack_bar.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/photo_selector.dart';
import '../widgets/sign_up_flow_screen.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  String? imgPath;
  @override
  Widget build(BuildContext context) {
    return SignUpFlowScreen(
      onNextPressed: () {
        if (imgPath != null) {
          context.read<SignUpCubit>().onSelectImageComplete(imgPath!);
        } else {
          FSnackBar.showSnackBar('Please choose your image');
        }
      },
      title: 'Upload Your Photo Profile',
      subTitle:
          'This data will be displayed in your account profile for security',
      child: imgPath == null
          ? PhotoSelector(
              onImgSelected: (value) => setState(
                () => imgPath = value,
              ),
            )
          : FProfilePhoto(imgPath: imgPath),
    );
  }
}

class FProfilePhoto extends StatelessWidget {
  const FProfilePhoto({
    super.key,
    required this.imgPath,
  });

  final String? imgPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: const BoxDecoration(
          borderRadius: Ui.borderRadius,
        ),
        child: Image.file(
          File(imgPath!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
