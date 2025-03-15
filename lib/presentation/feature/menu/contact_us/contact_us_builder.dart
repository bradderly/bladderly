// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/contact_us_usecase.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/contact_us_view.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsBuilder extends StatelessWidget {
  const ContactUsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactUsBloc>(
          create: (_) => ContactUsBloc(
            contactUsUsecase: getIt<ContactUsUsecase>(),
          ),
        ),
        BlocProvider<ContactUsFormCubit>(
          create: (_) => ContactUsFormCubit(),
        ),
      ],
      child: const ContactUsView(),
    );
  }
}
