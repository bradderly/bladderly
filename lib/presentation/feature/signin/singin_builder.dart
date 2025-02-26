import 'package:bradderly/presentation/feature/signin/cubit/signin_form_cubit.dart';
import 'package:bradderly/presentation/feature/signin/signin_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SinginBuilder extends StatelessWidget {
  const SinginBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SigninFormCubit(),
      child: const SigninView(),
    );
  }
}
