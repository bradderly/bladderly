// Flutter imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/tutorial/how_to_use/how_to_use_view.dart';

class HowToUseBuilder extends StatelessWidget {
  const HowToUseBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>.value(
      value: context.read<UserBloc>(),
      child: const HowtouseView(),
    );
  }
}
