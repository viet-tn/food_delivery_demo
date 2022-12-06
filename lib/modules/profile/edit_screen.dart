import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../repositories/users/user_model.dart';
import '../../utils/ui/forms/edit_profile_form.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/loading_screen.dart';
import '../../utils/ui/scaffold.dart';
import '../../utils/ui/snack_bar.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/dialogs/alert_dialog.dart';
import '../cubits/app/app_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _appCubit = GetIt.I<AppCubit>();
  late final FUser _user = _appCubit.state.user!;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final _currentPasswordController = TextEditingController();
  late final _newPasswordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  String? _imgUrl;
  final _formKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: _user.firstName);
    _lastNameController = TextEditingController(text: _user.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: _onBackButtonPressed,
          child: ListenError<AppCubit>(
            child: LoadingScreen(
              isLoading: state.status.isLoading,
              child: FScaffold(
                centerBottomButton: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GradientButton(
                    width: double.infinity,
                    onPressed: _onChangeInfomationPressed,
                    child: const Text(
                      'Change Infomation',
                      style: FTextStyles.button,
                    ),
                  ),
                ),
                body: SizedBox.expand(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FAppBar(
                          onPressed: () async {
                            final isDisCarded = await _onBackButtonPressed();
                            if (isDisCarded) {
                              FCoordinator.onBack();
                            }
                          },
                          title: 'Edit Profile',
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: Ui.screenPadding,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              BlocBuilder<AppCubit, AppState>(
                                buildWhen: (previous, current) =>
                                    previous.user != current.user,
                                builder: (context, state) {
                                  return EditProfileForm(
                                    formKey: _formKey,
                                    changePasswordFormKey:
                                        _changePasswordFormKey,
                                    user: state.user!,
                                    onImageChanged: (imgUrl) =>
                                        _imgUrl = imgUrl,
                                    firstNameController: _firstNameController,
                                    lastNameController: _lastNameController,
                                    currentPasswordController:
                                        _currentPasswordController,
                                    newPasswordController:
                                        _newPasswordController,
                                    confirmPasswordController:
                                        _confirmPasswordController,
                                  );
                                },
                              ),
                              gapH20,
                              SizedBox(
                                height: 57.0,
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: _onDeleteAccountPressed,
                                  child: Text(
                                    'Delete Account',
                                    style: FTextStyles.button.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Sizes.navBarGapH,
                            ],
                          ),
                        ),
                      ),
                      gapH32,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onDeleteAccountPressed() async {
    bool? isConfirmed;
    isConfirmed = await showDialog<bool>(
      context: context,
      builder: (_) {
        return const FAlertDialog(
            title: 'Are you sure you wan to delete account forever !');
      },
    );
    if (isConfirmed ?? false) {
      FCoordinator.onBack();
      GetIt.I<AppCubit>().deleteUserFromDatabase();
    }
  }

  Future<bool> _onBackButtonPressed() async {
    bool? isDiscarded;
    isDiscarded = await showDialog<bool>(
      context: context,
      builder: (context) {
        return const FAlertDialog(
            title: 'Any unsaved changes will be discarded ?');
      },
    );
    if (isDiscarded ?? false) {
      //TODO: Fetch user from database to AppCubit
      return true;
    }
    return false;
  }

  void _onChangeInfomationPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final bool hasTypedInChangePasswordSection =
        _currentPasswordController.text.isNotEmpty ||
            _newPasswordController.text.isNotEmpty ||
            _confirmPasswordController.text.isNotEmpty;

    if (hasTypedInChangePasswordSection &&
        !_changePasswordFormKey.currentState!.validate()) return;

    if (!_formKey.currentState!.validate()) return;

    if (hasTypedInChangePasswordSection) {
      _appCubit.changePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }

    final update = GetIt.I<AppCubit>().state.user!.copyWith(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
        );

    // return if not change anything
    if (update == GetIt.I<AppCubit>().state.user! && _imgUrl == null) return;

    _appCubit.updateUserState(update);
    await _appCubit.updateUserToDatabase(_imgUrl);
    FSnackBar.showSnackBar(
      'Saved',
      Colors.black87,
    );
  }
}
