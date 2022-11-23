import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/ui/listen_error.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/bio_form.dart';
import '../widgets/sign_up_flow_screen.dart';

class FillBioScreen extends StatefulWidget {
  const FillBioScreen({super.key});

  @override
  State<FillBioScreen> createState() => _FillBioScreenState();
}

class _FillBioScreenState extends State<FillBioScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late String _phoneNumber;

  String get _firstName => _firstNameController.text;
  String get _lastName => _lastNameController.text;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenError<SignUpCubit>(
      child: SignUpFlowScreen(
        onNextPressed: () async {
          if (_formKey.currentState!.validate()) {
            await context
                .read<SignUpCubit>()
                .onBioSubmitted(_firstName, _lastName, _phoneNumber);
          }
        },
        showBackButton: false,
        title: 'Fill in your bio to get started',
        subTitle:
            'This data will be displayed in your account profile for security',
        child: BioForm(
          formKey: _formKey,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          onPhoneNumberChanged: (phone) => _phoneNumber = phone,
        ),
      ),
    );
  }
}
