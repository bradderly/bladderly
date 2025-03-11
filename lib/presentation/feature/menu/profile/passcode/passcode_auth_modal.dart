// ignore_for_file: use_build_context_synchronously

import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class PasscodeAuthModal extends StatefulWidget {
  const PasscodeAuthModal({super.key});

  @override
  State<PasscodeAuthModal> createState() => _PasscodeAuthModalState();
}

class _PasscodeAuthModalState extends State<PasscodeAuthModal> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // 키보드 자동 포커스 노드
  String firstInput = '';
  bool isUncorrect = false;

  @override
  void initState() {
    super.initState();
    _requestFocusAndAuthenticate();
  }

  Future<void> _requestFocusAndAuthenticate() async {
    Future.delayed(const Duration(milliseconds: 300), _focusNode.requestFocus);
    await _auth();
  }

  Future<void> _auth() async {
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
            return const MainRoute().go(context);
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
      // Android일 때는 바로 비밀번호 입력
    }
  }

  void onPasscodeEntered(String inputPasscode) {
    final passcode = context.read<PasscodeCubit>().state.passcode;
    if (passcode == inputPasscode) {
      // 성공 시 화면이동
      return const MainRoute().go(context);
    } else {
      _controller.clear();
      setState(() {
        isUncorrect = true;
      });
    }
  }

  Widget buildPasscodeDots(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < length ? context.colorTheme.neutral.shade6 : Colors.transparent,
            border: Border.all(color: context.colorTheme.neutral.shade6),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 뒤로가기 버튼을 막음
      child: DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.95,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Text(
                  'Passcode'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const SizedBox(height: 173),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(_focusNode); // 점 UI 클릭 시 키보드 활성화
                  },
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Set your passcode below'.tr(context),
                          style: context.textStyleTheme.b16Medium.copyWith(
                            color: context.colorTheme.neutral.shade6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildPasscodeDots(_controller.text.length), // 클릭 가능한 점 UI
                        const SizedBox(height: 20),
                        if (isUncorrect)
                          Text(
                            'The passcode you entered is incorrect.\nPlease try again.'.tr(context),
                            style: context.textStyleTheme.b14Medium.copyWith(
                              color: context.colorTheme.warning,
                            ),
                          ),
                        // 👇 텍스트 필드를 완전히 숨김
                        Opacity(
                          opacity: 0,
                          // ignore: sized_box_shrink_expand
                          child: SizedBox(
                            width: 0,
                            height: 0,
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {}); // 입력값 변화 감지
                                if (value.length == 4) {
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    onPasscodeEntered(value);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
