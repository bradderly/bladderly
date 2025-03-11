// ignore_for_file: sized_box_shrink_expand

import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class PasscodeInputScreen extends StatefulWidget {
  const PasscodeInputScreen({super.key});

  @override
  State<PasscodeInputScreen> createState() => _PasscodeInputScreenState();
}

class _PasscodeInputScreenState extends State<PasscodeInputScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // 키보드 자동 포커스 노드
  bool isFirstAttempt = true;
  bool isUncorrect = false;
  String firstInput = '';
  String secondInput = '';

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // 키보드 자동 포커스
  }

  void onPasscodeEntered(String passcode) {
    if (passcode.length == 4) {
      if (isFirstAttempt) {
        firstInput = passcode;
        _controller.clear();
        setState(() {
          isFirstAttempt = false;
          isUncorrect = false;
        });
      } else {
        secondInput = passcode;
        if (firstInput == secondInput) {
          Navigator.pop(context, firstInput); // 성공 시 true 반환
        } else {
          _controller.clear();
          setState(() {
            firstInput = '';
            secondInput = '';
            isFirstAttempt = true;
            isUncorrect = true;
          });
        }
      }
    }
  }

  Widget buildPasscodeDots(int length) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode); // 점 UI 클릭 시 키보드 활성화
      },
      child: Row(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
              ModalTitle(title: 'Passcode'.tr(context)),
              const SizedBox(height: 38),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isFirstAttempt ? 'Set your passcode below'.tr(context) : 'Confirm your passcode'.tr(context),
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
              Expanded(
                child: Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
