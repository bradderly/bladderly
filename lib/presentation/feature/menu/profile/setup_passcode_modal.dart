import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class SetupPasscodeModal extends StatefulWidget {
  const SetupPasscodeModal({super.key});

  @override
  State<SetupPasscodeModal> createState() => _SetupPasscodeModalState();
}

class _SetupPasscodeModalState extends State<SetupPasscodeModal> {
  bool isSwitched = false;

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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Set Up Passcode'.tr(context)),
                    const SizedBox(height: 38),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 9,
                              right: 16,
                              bottom: 8,
                            ),
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
                                    setState(() {
                                      isSwitched = !isSwitched;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 51,
                                    height: 31,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: isSwitched
                                          ? context.colorTheme.vermilion.primary.shade50
                                          : const Color(0x78788029),
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
                                        TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 3000,
                                          ),
                                          curve: Curves.easeOutBack, // 살짝 튕기는 효과 추가
                                          tween: Tween<double>(
                                            begin: isSwitched ? 2 : 22,
                                            end: isSwitched ? 22 : 2,
                                          ),
                                          builder: (context, value, child) {
                                            return Positioned(
                                              left: value,
                                              top: 2,
                                              child: Container(
                                                width: 27,
                                                height: 27,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 4,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 36),
                          // Description Text
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Save'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
