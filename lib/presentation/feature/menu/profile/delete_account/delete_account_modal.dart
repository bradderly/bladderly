// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account/bloc/delete_account_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/delete_account/modal/delete_account_confirm_modal.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/reason_option.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountModal extends StatefulWidget {
  const DeleteAccountModal({super.key});

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  String? selectedReason;

  final List<String> reasons = [
    'I am switching to different plans',
    'I achieved my goal',
    'I am not using enough',
    'I wasn’t satisfied with or had issues with the features, including technical difficulties',
    'I found an alternative service',
    'Other',
  ];

  void _onDeleteAccount(
    BuildContext context,
  ) {
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;
    final emailText = userModel is RegularUserModel ? userModel.email : '';
    context.read<DeleteAccountBloc>().add(
          DeleteAccount(
            email: emailText,
            id: userModel.id,
            reason: selectedReason ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) => switch (state) {
        DeleteAccountInitial() => ProgressIndicatorModal.show(context),
        DeleteAccountSuccess() => context.signOut(),
        DeleteAccountFailure() => {},
        _ => null,
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
        child: Column(
          children: [
            ModalTitle(title: 'Delete Account'.tr(context)),
            const SizedBox(height: 58),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 32),
                    child: Text(
                      'Delete account Message'.tr(context),
                      style: context.textStyleTheme.b16Medium.copyWith(
                        color: context.colorTheme.neutral.shade10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 47),
                  ...reasons.map(
                    (reason) => ReasonOption(
                      reason: reason.tr(context),
                      isSelected: selectedReason == reason,
                      onSelect: () {
                        setState(() {
                          selectedReason = reason;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (selectedReason == null) {
                  return;
                }
                DeleteAccountConfirmModal.show(context, onConfirm: () => _onDeleteAccount(context));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: (selectedReason == null)
                      ? context.colorTheme.neutral.shade6
                      : context.colorTheme.vermilion.primary.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Next'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
