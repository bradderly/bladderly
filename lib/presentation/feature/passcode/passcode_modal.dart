// ignore_for_file: use_build_context_synchronously

import 'package:bladderly/core/bio_auth/bio_auth.dart';
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
// PasscodeCubit 가져오기
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PasscodeModal extends StatelessWidget {
  const PasscodeModal({super.key});

  Future<void> _authenticate(BuildContext context) async {
    final canBioAuthenticate = await BioAuth().canAuthenticate();

    final didAuthenticate = switch (canBioAuthenticate) {
      true => await BioAuth().authenticate(),
      false => await Future.value(true),
    };

    if (!didAuthenticate || !context.mounted) return;

    const PasscodeSetRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: 'Set Up Passcode'.tr(context)),
      body: SafeArea(
        child: BlocBuilder<PasscodeCubit, PasscodeState>(
          builder: (context, state) => Column(
            children: [
              Expanded(
                child: ListView(
                  controller: ModalScrollController.of(context),
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  switch (defaultTargetPlatform) {
                                    TargetPlatform.iOS => 'Lock with Face ID & Passcode'.tr(context),
                                    TargetPlatform.android => 'Lock with Passcode'.tr(context),
                                    _ => '',
                                  },
                                  style: context.textStyleTheme.b16Medium.copyWith(
                                    color: context.colorTheme.neutral.shade10,
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => context.read<PasscodeCubit>().state.isLocked
                                      ? context.read<PasscodeCubit>().unlock()
                                      : _authenticate(context),
                                  child: Container(
                                    width: 51,
                                    height: 31,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: context.read<PasscodeCubit>().state.isLocked
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
                                          left: context.read<PasscodeCubit>().state.isLocked
                                              ? 20.0
                                              : 0.0, // 오른쪽이면 20.0, 아니면 0.0
                                          right: context.read<PasscodeCubit>().state.isLocked
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
                                              color: context.read<PasscodeCubit>().state.isLocked
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
              BlocSelector<PasscodeCubit, PasscodeState, bool>(
                selector: (state) => state.isLocked,
                builder: (context, isLocked) => PrimaryButton.filled(
                  onPressed: isLocked ? () => const PasscodeChangeRoute().go(context) : null,
                  backgroundColor: context.read<PasscodeCubit>().state.isLocked
                      ? context.colorTheme.vermilion.primary.shade50
                      : context.colorTheme.neutral.shade6,
                  text: 'Change passcode'.tr(context),
                  borderRadius: 8,
                  shape: BoxShape.rectangle,
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size(256, 48),
                ),
              ),
              const Gap(28),
            ],
          ),
        ),
      ),
    );
  }
}
