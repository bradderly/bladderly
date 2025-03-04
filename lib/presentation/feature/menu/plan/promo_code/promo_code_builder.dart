// Flutter imports:
import 'package:bladderly/domain/usecase/promo_code_usecase.dart';
import 'package:bladderly/presentation/feature/menu/plan/promo_code/bloc/promo_code_bloc.dart';
import 'package:bladderly/presentation/feature/menu/plan/promo_code/cubit/promo_code_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/plan/promo_code/promo_code_modal.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';

class PromoCodeBuilder extends StatelessWidget {
  const PromoCodeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PromoCodeFormCubit>(
          create: (_) => PromoCodeFormCubit(),
        ),
        BlocProvider<PromoCodeBloc>(
          create: (_) => PromoCodeBloc(
            promoCodeUsecase: getIt<PromoCodeUsecase>(),
          ),
        ),
      ],
      child: const PromoCodeModal(),
    );
  }
}
