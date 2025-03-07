// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsModal extends StatelessWidget {
  const ContactUsModal({super.key});

  void _onSendMessage(
    BuildContext context,
  ) {
    /// TODO(김원응): cubit 수정 및 블록 호출부 구현 필요
    // context.read<ContactUsBloc>().add(
    //       ContactUs(
    //         firstName: context.read<ContactUsFormCubit>().state.firstName,
    //         lastName: context.read<ContactUsFormCubit>().state.lastName,
    //         email: context.read<ContactUsFormCubit>().state.email,
    //         subject: context.read<ContactUsFormCubit>().state.subject,
    //         message: context.read<ContactUsFormCubit>().state.message,
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;
    final userName = userModel is RegularUserModel ? userModel.name : '';
    final userEmail = userModel is RegularUserModel ? userModel.email : '';

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return BlocListener<ContactUsBloc, ContactUsState>(
          listener: (context, state) => switch (state) {
            ContactUsInitial() => ProgressIndicatorModal.show(context),
            ContactUsSuccess() => {
                Navigator.of(context).pop(),
              },
            ContactUsFailure() => {},
            _ => null,
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 41),
            child: Column(
              children: [
                ModalTitle(context, 'Contact us'.tr(context)),
                const SizedBox(height: 42.5),
                Expanded(
                  child: BlocSelector<ContactUsFormCubit, ContactUsFormState, ContactUsFormState>(
                    selector: (state) => state,
                    builder: (_, obscureOldPassword) => ListView(
                      controller: controller,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name'.tr(context),
                                style: context.textStyleTheme.b14Medium.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                ),
                              ),
                              TextFormField(
                                onChanged: (value) => context.read<ContactUsFormCubit>().setFirstName(value),
                                initialValue: userName.substring(1),
                                style: context.textStyleTheme.b16Medium.copyWith(
                                  color: context.colorTheme.neutral.shade10,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 8,
                                    top: 2,
                                  ), // Adjust this value to move the underline closer
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.colorTheme.neutral.shade5,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name'.tr(context),
                                style: context.textStyleTheme.b14Medium.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                ),
                              ),
                              TextFormField(
                                onChanged: (value) => context.read<ContactUsFormCubit>().setLastName(value),
                                initialValue: userName.substring(0, 1),
                                style: context.textStyleTheme.b16Medium.copyWith(
                                  color: context.colorTheme.neutral.shade10,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 8,
                                    top: 2,
                                  ), // Adjust this value to move the underline closer
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.colorTheme.neutral.shade5,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'Email Address'.tr(context)} *',
                                style: context.textStyleTheme.b14Medium.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                ),
                              ),
                              TextFormField(
                                onChanged: (value) => context.read<ContactUsFormCubit>().setEmail(value),
                                initialValue: userEmail,
                                style: context.textStyleTheme.b16Medium.copyWith(
                                  color: context.colorTheme.neutral.shade10,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 8,
                                    top: 2,
                                  ), // Adjust this value to move the underline closer
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.colorTheme.neutral.shade5,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'Subject'.tr(context)} *',
                                style:
                                    context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                              ),
                              const SizedBox(height: 11),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.colorTheme.neutral.shade2,
                                  border: Border.all(
                                    color: context.colorTheme.neutral.shade5,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  onChanged: (value) => context.read<ContactUsFormCubit>().setSubject(value),
                                  style: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade10),
                                  decoration: InputDecoration(
                                    hintText: 'Please enter the subject'.tr(context),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    hintStyle: context.textStyleTheme.b16Medium.copyWith(
                                      color: context.colorTheme.neutral.shade6,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'Message'.tr(context)} *',
                                style:
                                    context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                              ),
                              const SizedBox(height: 11),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.colorTheme.neutral.shade2,
                                  border: Border.all(
                                    color: context.colorTheme.neutral.shade5,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  onChanged: (value) => context.read<ContactUsFormCubit>().setMessage(value),
                                  style: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade10),
                                  decoration: InputDecoration(
                                    hintText: 'Please enter the message'.tr(context),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    hintStyle: context.textStyleTheme.b16Medium.copyWith(
                                      color: context.colorTheme.neutral.shade6,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text(
                            '* Required fields',
                            style: context.textStyleTheme.b16Medium.copyWith(
                              color: context.colorTheme.neutral.shade6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<ContactUsFormCubit, ContactUsFormState, bool>(
                  selector: (state) => state.isValid,
                  builder: (context, isValid) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isValid ? () => _onSendMessage(context) : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Submit'.tr(context),
                        style: context.textStyleTheme.b16SemiBold.copyWith(
                          color: context.colorTheme.neutral.shade0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
