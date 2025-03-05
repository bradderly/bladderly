// ignore_for_file: use_build_context_synchronously

import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/feature/menu/profile/passcode/passcode_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/foundation.dart'; // 추가: 플랫폼 정보를 가져오기 위해 사용

// PasscodeCubit 가져오기
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class PasscodeModal extends StatelessWidget {
  const PasscodeModal({super.key});

  Future<void> authenticate(BuildContext context) async {
    final auth = LocalAuthentication();

    // 플랫폼이 Android가 아닌 경우에만 생체 인증을 시도
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.android) {
      final canCheckBiometrics = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        try {
          final didAuthenticate = await auth.authenticate(
            localizedReason: '얼굴 인식을 사용하여 로그인하세요.',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (didAuthenticate) {
            // 생체 인증 성공 -> 비밀번호 입력 화면으로 이동
            final result = await showModalBottomSheet<bool>(
              context: context,
              isScrollControlled: true, // 컨텐츠 크기에 맞춰서 스크롤
              backgroundColor: Colors.transparent, // 배경 투명 설정
              builder: (BuildContext context) {
                return const PasscodeInputScreen();
              },
            );
            if (result == true) {
              // 비밀번호 설정 성공
              context.read<PasscodeCubit>().toggleBiometric(true);
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('인증 오류: $e');
          }
        }
      } else {
        if (kDebugMode) {
          print('Face ID 사용 불가');
        }
      }
    } else {
      // Android일 때는 생체 인증 건너뛰기
      final result = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true, // 컨텐츠 크기에 맞춰서 스크롤
        backgroundColor: Colors.transparent, // 배경 투명 설정
        builder: (BuildContext context) {
          return const PasscodeInputScreen();
        },
      );
      if (result == true) {
        // 비밀번호 설정 성공
        context.read<PasscodeCubit>().toggleBiometric(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return BlocBuilder<PasscodeCubit, PasscodeState>(
          // BlocBuilder로 상태 변경 감지
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
              child: Column(
                children: [
                  ModalTitle(context, 'Set Up Passcode'.tr(context)),
                  const SizedBox(height: 38),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.colorTheme.neutral.shade2,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Lock with Face ID & Passcode'.tr(context),
                                      style: context.textStyleTheme.b16Medium.copyWith(
                                        color: context.colorTheme.neutral.shade10,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (context.read<PasscodeCubit>().state.isBiometricEnabled) {
                                          context.read<PasscodeCubit>().toggleBiometric(false);
                                          context.read<PasscodeCubit>().clearPasscode();
                                        } else {
                                          authenticate(context);
                                        }
                                      },
                                      child: Container(
                                        width: 51,
                                        height: 31,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: context.read<PasscodeCubit>().state.isBiometricEnabled
                                              ? context.colorTheme.vermilion.primary.shade50
                                              : const Color(0x29787880),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            // 흰색 또는 주황색 동그라미
                                            Positioned(
                                              left: context.read<PasscodeCubit>().state.isBiometricEnabled
                                                  ? 20.0
                                                  : 0.0, // 오른쪽이면 20.0, 아니면 0.0
                                              right: context.read<PasscodeCubit>().state.isBiometricEnabled
                                                  ? 0.0
                                                  : 20.0, // 왼쪽이면 20.0, 아니면 0.0
                                              top: 3,
                                              bottom: 3,
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 300),
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: context.read<PasscodeCubit>().state.isBiometricEnabled
                                                      ? Colors.white // Biometric가 활성화되었으면 주황색
                                                      : Colors.white, // 그렇지 않으면 흰색
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 36),
                              Text(
                                'Passcode Message'.tr(context),
                                style: context.textStyleTheme.b14Medium.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
