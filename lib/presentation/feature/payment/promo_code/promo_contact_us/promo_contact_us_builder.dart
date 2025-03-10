// Flutter imports:
import 'package:bladderly/presentation/feature/payment/promo_code/promo_contact_us/promo_contact_us_view.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/contact_us_usecase.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';

class PromoContactUsBuilder extends StatelessWidget {
  const PromoContactUsBuilder({super.key});

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
          lazy: false, // ✅ 즉시 생성
        ),
      ],
      child: const PromoContactUsView(), // ✅ 여기서는 Bloc을 제공받아서 사용
    );
  }
}
