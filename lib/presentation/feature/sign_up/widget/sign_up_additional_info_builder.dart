import 'package:bladderly/presentation/feature/sign_up/cubit/sign_up_additional_info_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_additional_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpAdditionalInfoBuilder extends StatelessWidget {
  const SignUpAdditionalInfoBuilder({
    super.key,
    required this.onSubmit,
  });

  final void Function(SignUpAdditionalInfoFormState state) onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpAdditionalInfoFormCubit>(
      create: (_) => SignUpAdditionalInfoFormCubit(),
      child: SignUpAdditionalInfoView(
        onSubmit: onSubmit,
      ),
    );
  }
}
