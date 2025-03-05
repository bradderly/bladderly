// Flutter imports:
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/feature/menu/profile/passcode/passcode_modal.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class PasscodeBuilder extends StatelessWidget {
  const PasscodeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasscodeCubit(),
      child: const PasscodeModal(),
    );
  }
}
