// ignore_for_file: non_constant_identifier_names

import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoContactUsView extends StatelessWidget {
  const PromoContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;
    final contactUsFormCubit = context.read<ContactUsFormCubit>();

    if (userModel is RegularUserModel) {
      contactUsFormCubit.initializeForm(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
      );
    } else {
      contactUsFormCubit.setId(userModel.id);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 76),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Having trouble finding the code?'.tr(context),
                  style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
                const SizedBox(height: 16),
                Text(
                  'Leave us a message, and we’ll get back to you.'.tr(context),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
                ),
                const SizedBox(height: 32),
                BlocBuilder<ContactUsFormCubit, ContactUsFormState>(
                  builder: (context, formState) {
                    final contactUsFormCubit = context.read<ContactUsFormCubit>(); // ✅ 이제 context가 올바르게 Bloc을 읽을 수 있음
                    return Column(
                      children: [
                        InputTextBorderForm('Bladderly ID', formState.id, 1, context, isModified: true),
                        InputTextBorderForm(
                          'Preferred Name',
                          formState.name,
                          1,
                          context,
                          onChanged: contactUsFormCubit.setName,
                        ),
                        InputTextBorderForm(
                          'Email Address',
                          formState.email,
                          1,
                          context,
                          onChanged: contactUsFormCubit.setEmail,
                        ),
                        InputTextBorderForm(
                          'Message',
                          formState.message,
                          3,
                          context,
                          onChanged: contactUsFormCubit.setMessage,
                          isMessage: true,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formState.email.isEmpty || formState.message.isEmpty) {
                              return;
                            }
                            context.read<ContactUsBloc>().add(
                                  ContactUs(
                                    userId: formState.id,
                                    userEmail: formState.email,
                                    userName: formState.name,
                                    message: formState.message,
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 28),
                            padding: const EdgeInsets.only(top: 19, bottom: 18),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: formState.isValid
                                  ? context.colorTheme.vermilion.primary.shade50
                                  : context.colorTheme.neutral.shade6,
                              borderRadius: BorderRadius.circular(400),
                            ),
                            child: Text(
                              'Okay'.tr(context),
                              style:
                                  context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget InputTextBorderForm(
    String title,
    String value,
    int maxlines,
    BuildContext context, {
    bool isMessage = false,
    bool isModified = false,
    void Function(String)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr(context),
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
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
              readOnly: isModified,
              initialValue: value,
              maxLines: maxlines,
              style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
              decoration: InputDecoration(
                hintText: isMessage ? 'promo code message text'.tr(context) : '',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                hintStyle: context.textStyleTheme.b16Medium.copyWith(
                  color: context.colorTheme.neutral.shade6,
                ),
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
