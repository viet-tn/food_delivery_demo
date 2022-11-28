import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../repositories/users/user_model.dart';
import '../../utils/helpers/image_converter.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/textfield/text_field.dart';
import '../cubit/app_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenError<AppCubit>(
      child: FScaffold(
        body: SizedBox.expand(
          child: Column(
            children: [
              SizedBox.fromSize(
                size: const Size.fromHeight(60.0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    FBackButton(onPressed: Navigator.of(context).pop),
                    const Center(
                      child: Text(
                        'Edit Profile',
                        style: FTextStyles.heading3,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  padding: Ui.screenPadding,
                  child: EditProfileForm(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, FUser>(
      // [state.user] cannot null because of [_init] function in cubit
      selector: (state) => state.user!,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Form(
            child: Column(
              children: [
                ChangeAvatar(
                  image:
                      ImageConverter.imageFromBase64String(state.photo!).image,
                ),
                gapH48,
                FTextField(
                  enabled: false,
                  labelText: 'Email',
                  initialValue: state.email,
                  textStyle: FTextStyles.body.copyWith(color: Colors.grey),
                ),
                gapH32,
                FTextField(
                  enabled: false,
                  labelText: 'Phone number',
                  initialValue: state.phone,
                  textStyle: FTextStyles.body.copyWith(color: Colors.grey),
                ),
                gapH32,
                Row(
                  children: [
                    Expanded(
                      child: FTextField(
                        labelText: 'First name',
                        initialValue: state.firstName,
                      ),
                    ),
                    gapW12,
                    Expanded(
                      child: FTextField(
                        labelText: 'Last name',
                        initialValue: state.lastName,
                      ),
                    ),
                  ],
                ),
                gapH32,
                const FTextField(
                  labelText: 'Location',
                  initialValue: 'Not set location',
                ),
                gapH32,
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChangeAvatar extends StatelessWidget {
  const ChangeAvatar({
    super.key,
    required this.image,
  });

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 150.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
                onError: (_, __) => const FlutterLogo(size: 150.0),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {},
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
