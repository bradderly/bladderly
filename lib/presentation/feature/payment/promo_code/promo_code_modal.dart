// Flutter imports:

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/bloc/promo_code_bloc.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/cubit/promo_code_form_cubit.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_contact_us/promo_contact_us_builder.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoCodeModal extends StatefulWidget {
  const PromoCodeModal({super.key});

  @override
  State<PromoCodeModal> createState() => _PromoCodeModalState();
}

class _PromoCodeModalState extends State<PromoCodeModal> {
  void failToast() {
    showDialog<void>(
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
                behavior: HitTestBehavior.translucent,
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<PromoCodeBloc, PromoCodeState>(
      listener: (context, state) {
        if (state is PromoCodeProgress) {
          ProgressIndicatorModal.show(context); // 로딩 표시
        } else if (state is PromoCodeSuccess) {
          Navigator.of(context).pop(); // 성공 시 모달 닫기
          Navigator.of(context).pop(); // 화면 뒤로가기
        } else if (state is PromoCodeFailure) {
          // 실패 시 에러 처리
          failToast();
        }
      },
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                ModalTitle(title: 'Promo Code'.tr(context)),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
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
                      BlocBuilder<PromoCodeFormCubit, PromoCodeFormState>(
                        builder: (_, formState) => TextFormField(
                          initialValue: formState.code,
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
                          onChanged: (value) {
                            context.read<PromoCodeFormCubit>().setCode(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) {
                        return const PromoContactUsBuilder();
                      },
                    ),
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
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // PromoCodeBloc에 이벤트를 전달
                    final tempCode = context.read<PromoCodeFormCubit>().state.code;
                    if (tempCode.isEmpty) {
                      return;
                    }

                    final promoCode = PromoCode(
                      userId: context.read<UserBloc>().state.userModelOrThrowException.id, // 여기에 실제 사용자 ID를 넣어야 합니다.
                      code: tempCode,
                    );
                    context.read<PromoCodeBloc>().add(promoCode);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.symmetric(horizontal: 44),
                    decoration: BoxDecoration(
                      color: context.colorTheme.vermilion.primary.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Apply'.tr(context),
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
      ),
    );
  }
}
