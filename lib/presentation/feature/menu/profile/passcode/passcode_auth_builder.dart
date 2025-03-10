// Flutter imports:
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/feature/menu/profile/passcode/passcode_auth_modal.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class PasscodeAuthBuilder extends StatelessWidget {
  const PasscodeAuthBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PasscodeCubit()), // ✅ 여기에서 PasscodeCubit 유지
      ],
      child: BlocBuilder<PasscodeCubit, PasscodeState>(
        builder: (context, state) {
          if (state.isBiometricEnabled) {
            return const PasscodeAuthModal();
          } else {
            // 생체 인증이 비활성화된 경우 창을 닫음
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context); // 현재 화면을 닫습니다.
            });
            return const SizedBox.shrink(); // 빈 화면을 반환하여 추가 UI를 렌더링하지 않음
          }
        },
      ),
    );
  }
}
