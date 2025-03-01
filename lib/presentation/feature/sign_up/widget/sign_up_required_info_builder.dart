// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/feature/sign_up/cubit/sign_up_required_info_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_required_info_view.dart';

class SignUpRequiredInfoBuilder extends StatelessWidget {
  const SignUpRequiredInfoBuilder({
    super.key,
    required this.onSubmit,
    required this.yearOfBirthFocusNode,
  });

  final void Function(SignUpRequiredInfoFormState) onSubmit;
  final FocusNode yearOfBirthFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpRequiredInfoFormCubit>(
      create: (context) => SignUpRequiredInfoFormCubit(),
      child: SignUpRequiredInfoView(
        onSubmit: onSubmit,
        yearOfBirthFocusNode: yearOfBirthFocusNode,
      ),
    );
  }
}
