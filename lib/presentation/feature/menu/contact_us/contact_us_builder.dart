// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/contact_us_usecase.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/contact_us_modal.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';

class ContactUsBuilder extends StatelessWidget {
  const ContactUsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;
    final userName = userModel is RegularUserModel ? userModel.name : '';
    final userEmail = userModel is RegularUserModel ? userModel.email : '';
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactUsBloc>(
          create: (_) => ContactUsBloc(
            contactUsUsecase: getIt<ContactUsUsecase>(),
          ),
        ),
        BlocProvider<ContactUsFormCubit>(
          create: (_) => ContactUsFormCubit(
            initialEmail: userEmail,
            initialFirstName: userName.substring(1),
            initialLastName: userName.substring(0, 1),
          ),
        ),
      ],
      child: const ContactUsModal(),
    );
  }
}
