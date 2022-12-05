import 'dart:io';

import 'package:flutter/material.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../modules/profile/widgets/change_password_section.dart';
import '../../../modules/profile/widgets/widgets.dart';
import '../../../modules/signup/widgets/location_selector.dart';
import '../../../repositories/domain_manager.dart';
import '../../../repositories/users/user_model.dart';
import '../../../widgets/textfield/text_field.dart';
import '../network_image.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.changePasswordFormKey,
    required this.user,
    required this.firstNameController,
    required this.lastNameController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    this.onImageChanged,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> changePasswordFormKey;
  final FUser user;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final void Function(String imgUrl)? onImageChanged;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final FUser _user = widget.user;
  String? _imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            ChangeAvatar(
              onImageChanged: (imgUrl) {
                if (imgUrl != null) {
                  setState(() {
                    _imgUrl = imgUrl;
                    widget.onImageChanged?.call(_imgUrl!);
                  });
                }
              },
              image: _imgUrl != null
                  ? Image.file(
                      File(_imgUrl!),
                      fit: BoxFit.cover,
                    )
                  : FNetworkImage(
                      _user.photo!,
                      fit: BoxFit.cover,
                    ),
            ),
            gapH48,
            FTextField(
              enabled: false,
              labelText: 'Email',
              initialValue: widget.user.email,
              textStyle: FTextStyles.body.copyWith(color: Colors.grey),
            ),
            gapH32,
            FTextField(
              enabled: false,
              labelText: 'Phone number',
              initialValue: widget.user.phone,
              textStyle: FTextStyles.body.copyWith(color: Colors.grey),
            ),
            gapH32,
            Row(
              children: [
                Expanded(
                  child: FTextField(
                    controller: widget.firstNameController,
                    labelText: 'First name',
                    validator: (_) {
                      if (widget.firstNameController.text.trim() == '') {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                gapW12,
                Expanded(
                  child: FTextField(
                    controller: widget.lastNameController,
                    labelText: 'Last name',
                    validator: (_) {
                      if (widget.lastNameController.text.trim() == '') {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            gapH32,
            LocationSelector(
              buttonLabel: 'Change location',
              address: widget.user.coordinates[0].address!,
              onSetLocationPressed: (latitude, longitude) {
                FCoordinator.showMapScreen(latitude, longitude);
              },
            ),
            gapH20,
            DomainManager()
                        .authRepository
                        .getUserProviderIds()
                        ?.contains('password') ??
                    false
                ? ChangePasswordSection(
                    formKey: widget.changePasswordFormKey,
                    currentPasswordController: widget.currentPasswordController,
                    newPasswordController: widget.newPasswordController,
                    confirmPasswordController: widget.confirmPasswordController,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
