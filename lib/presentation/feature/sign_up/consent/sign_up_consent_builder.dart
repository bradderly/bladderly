import 'package:bladderly/presentation/feature/sign_up/consent/cubit/sign_up_consent_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/consent/sign_up_consent_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpConsentBuilder extends StatelessWidget {
  const SignUpConsentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpConsentFormCubit>(
      create: (_) => SignUpConsentFormCubit(),
      child: const SignUpConsentView(),
    );
  }
}
