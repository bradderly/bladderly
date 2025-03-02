// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/input_text_border_form.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class PromoCodeModal extends StatefulWidget {
  const PromoCodeModal({super.key});

  @override
  State<PromoCodeModal> createState() => _PromoCodeModalState();
}

class _PromoCodeModalState extends State<PromoCodeModal> {
  final TextEditingController _controller = TextEditingController();
  bool _showErrorDialog = false;

  void _applyPromoCode() {
    setState(() {
      if (_controller.text != 'VALID-CODE') {
        // 예제 코드 검증
        _showErrorDialog = true;
      } else {
        _showErrorDialog = false;
      }
    });

    if (_showErrorDialog) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Invalid Code',
                  style: context.textStyleTheme.b18Bold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'That promo code didn’t work. Try entering it again, and if you’re still having trouble, email us at hello@bladderly.com for assistance.',
                  style: context.textStyleTheme.b14SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: Text(
                      'Okay',
                      style: context.textStyleTheme.b14SemiBold.copyWith(
                        color: const Color(0xFF007AFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ModalTitle(context, 'Promo Code'.tr(context)),
              const SizedBox(height: 40),
              Text(
                'Enter your code'.tr(context),
                style: context.textStyleTheme.b24Bold.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Promo Code'.tr(context),
                style: context.textStyleTheme.b14Medium.copyWith(
                  color: context.colorTheme.neutral.shade6,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'XXX-XXX',
                  filled: true,
                  fillColor: context.colorTheme.neutral.shade2,
                  hintStyle: context.textStyleTheme.b16Medium.copyWith(
                    color: context.colorTheme.neutral.shade9,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: context.colorTheme.neutral.shade0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // 둥근 모서리
                          ),
                          contentPadding: const EdgeInsets.only(top: 48, bottom: 48),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'Having trouble finding the code?'.tr(context),
                                  style: context.textStyleTheme.b20Bold
                                      .copyWith(color: context.colorTheme.neutral.shade10),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'Leave us a message, and we’ll get back to you.'.tr(context),
                                  style: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade7),
                                ),
                              ),
                              const SizedBox(height: 24),
                              InputTextBorderForm(
                                'First Name'.tr(context),
                                '',
                                1,
                                context,
                              ),
                              InputTextBorderForm(
                                'Last Name'.tr(context),
                                '',
                                1,
                                context,
                              ),
                              InputTextBorderForm(
                                'Email Adress'.tr(context),
                                '',
                                1,
                                context,
                              ),
                              InputTextBorderForm(
                                'Message'.tr(context),
                                'Add any notes or details here'.tr(context),
                                3,
                                context,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 24, top: 28, right: 24),
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: context.colorTheme.vermilion.primary.shade50,
                                        borderRadius: BorderRadius.circular(400),
                                      ),
                                      child: Text(
                                        'Okay'.tr(context),
                                        style: context.textStyleTheme.b16SemiBold.copyWith(
                                          color: context.colorTheme.neutral.shade0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Having trouble finding the code?'.tr(context),
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade6,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              GestureDetector(
                onTap: _applyPromoCode,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.symmetric(horizontal: 44),
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '등록',
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: Colors.white,
                    ),
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
