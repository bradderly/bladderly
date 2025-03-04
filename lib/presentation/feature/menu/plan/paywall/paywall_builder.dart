// Flutter imports:
import 'package:bladderly/domain/usecase/paywall_usecase.dart';
import 'package:bladderly/presentation/feature/menu/plan/paywall/bloc/paywall_bloc.dart';
import 'package:bladderly/presentation/feature/menu/plan/paywall/paywall_view.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';

class PaywallBuilder extends StatelessWidget {
  const PaywallBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaywallBloc>(
          create: (_) => PaywallBloc(
            paywallUsecase: getIt<PaywallUsecase>(),
          ),
        ),
      ],
      child: const PaywallView(),
    );
  }
}
