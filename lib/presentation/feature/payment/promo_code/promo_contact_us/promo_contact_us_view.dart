import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PromoContactUsView extends StatefulWidget {
  const PromoContactUsView({super.key});

  @override
  State<PromoContactUsView> createState() => _PromoContactUsViewState();
}

class _PromoContactUsViewState extends State<PromoContactUsView> {
  late final contactUsFormCubit = context.read<ContactUsFormCubit>();

  @override
  void initState() {
    super.initState();
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;

    if (userModel is RegularUserModel) {
      contactUsFormCubit.initializeForm(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
      );
    } else {
      contactUsFormCubit.setId(userModel.id);
    }
  }

  void _onSubmit(BuildContext context) {
    final state = context.read<ContactUsFormCubit>().state;

    context
        .read<ContactUsBloc>()
        .add(ContactUsSubmit(userId: state.id, userEmail: state.email, userName: state.name, message: state.message));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            builder: (context, state) => Column(
              children: [
                _inputTextBorderForm('Bladderly ID', state.id, 1, context, isModified: true),
                _inputTextBorderForm(
                  'Preferred Name',
                  state.name,
                  1,
                  context,
                  onChanged: contactUsFormCubit.setName,
                ),
                _inputTextBorderForm(
                  'Email Address',
                  state.email,
                  1,
                  context,
                  onChanged: contactUsFormCubit.setEmail,
                ),
                _inputTextBorderForm(
                  'Message',
                  state.message,
                  3,
                  context,
                  onChanged: contactUsFormCubit.setMessage,
                  isMessage: true,
                ),
                const Gap(28),
                PrimaryButton.filled(
                  onPressed: state.email.isEmpty || state.message.isEmpty ? null : () => _onSubmit(context),
                  backgroundColor: context.colorTheme.vermilion.primary.shade50,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Submit'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: context.pop,

                  // () {
                  //   if (formState.email.isEmpty || formState.message.isEmpty) {
                  //     return;
                  //   }
                  //
                  //   context.pop();
                  // },
                  child: Container(
                    padding: const EdgeInsets.only(top: 19, bottom: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: state.isValid
                          ? context.colorTheme.vermilion.primary.shade50
                          : context.colorTheme.neutral.shade6,
                      borderRadius: BorderRadius.circular(400),
                    ),
                    child: Text(
                      'Okay'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputTextBorderForm(
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
                color: Colors.transparent,
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
