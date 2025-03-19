// Flutter imports:

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/bloc/promo_code_bloc.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/cubit/promo_code_form_cubit.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_contact_us/promo_contact_us_builder.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PromoCodeView extends StatelessWidget {
  const PromoCodeView({super.key});

  Future<void> _onCheckSuccess(BuildContext context, PromoCodeCheckSuccess state) async {
    context.pop();

    return CommonMessageModal.show<void>(
      context,
      onTap: () => state.promoResult.needCheckMembership ? const MainRoute().go(context) : context.pop(),
      content: state.promoResult.popup,
    );
  }

  Future<void> _onCheckFailure(BuildContext context, PromoCodeCheckFailure state) async {}
  @override
  Widget build(BuildContext context) {
    return BlocListener<PromoCodeBloc, PromoCodeState>(
      listener: (context, state) => switch (state) {
        PromoCodeCheckInProgress() => ProgressIndicatorModal.show(context),
        PromoCodeCheckSuccess() => _onCheckSuccess(context, state),
        PromoCodeCheckFailure() => _onCheckFailure(context, state),
        _ => null
      },
      child: Scaffold(
        appBar: ModalAppBar(title: 'Promo Code'.tr(context)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: ModalScrollController.of(context),
                    physics: const ClampingScrollPhysics(),
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

                    final promoCode = PromoCodeCheck(
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
                const Gap(28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
