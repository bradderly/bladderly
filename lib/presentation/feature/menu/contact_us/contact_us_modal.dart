import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/bloc/contact_us_bloc.dart';
import 'package:bladderly/presentation/feature/menu/contact_us/cubit/contact_us_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class ContactUsModal extends StatefulWidget {
  const ContactUsModal({super.key});

  @override
  State<ContactUsModal> createState() => _ContactUsModalState();
}

class _ContactUsModalState extends State<ContactUsModal> {
  bool _isEmptyCheck = false;
  @override
  void initState() {
    super.initState();
    _setInitData();
  }

  void _setInitData() {
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;
    if (userModel is RegularUserModel) {
      context.read<ContactUsFormCubit>().initializeForm(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
          );
    } else {
      context.read<ContactUsFormCubit>().setId(
            userModel.id,
          );
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _onSendMessage(BuildContext context) {
    final formState = context.read<ContactUsFormCubit>().state;

    if (!_isEmailValid(formState.email)) {
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
  }

  void _errorCheck() {
    setState(() {
      _isEmptyCheck = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return BlocListener<ContactUsBloc, ContactUsState>(
          listener: (context, state) {
            if (state is ContactUsInitial) {
              ProgressIndicatorModal.show(context);
            } else if (state is ContactUsSuccess) {
              Navigator.of(context).pop();
            }
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
                  child: BlocBuilder<ContactUsFormCubit, ContactUsFormState>(
                    builder: (_, formState) => ListView(
                      controller: controller,
                      children: [
                        _buildInputField(context, 'Bladderly ID', formState.id, isModified: true),
                        _buildInputField(
                          context,
                          'Preferred Name',
                          formState.name,
                          onChanged: (value) => context.read<ContactUsFormCubit>().setName(value),
                        ),
                        const SizedBox(height: 8),
                        _buildTextArea(
                          context,
                          'Email Address',
                          formState.email,
                          1,
                          _isEmptyCheck && (formState.email.isEmpty || !_isEmailValid(formState.email)),
                          onChanged: (value) => context.read<ContactUsFormCubit>().setEmail(value),
                        ),
                        if (_isEmptyCheck && (formState.email.isEmpty || !_isEmailValid(formState.email)))
                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 8),
                            child: Text(
                              'Please enter a properly formatted email address.'.tr(context),
                              style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
                            ),
                          ),
                        _buildTextArea(
                          context,
                          'Message',
                          formState.message,
                          5,
                          _isEmptyCheck && formState.message.isEmpty,
                          onChanged: (value) => context.read<ContactUsFormCubit>().setMessage(value),
                        ),
                        if (_isEmptyCheck && formState.message.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 8),
                            child: Text(
                              'Please enter a message.'.tr(context),
                              style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text(
                            '* ${'Required fields'.tr(context)}',
                            style: context.textStyleTheme.b14Medium.copyWith(
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
                    onTap: isValid ? () => _onSendMessage(context) : _errorCheck,
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

  Widget _buildInputField(
    BuildContext context,
    String label,
    String? value, {
    bool isRequired = false,
    bool isModified = false,
    void Function(String)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label.tr(context)}${isRequired ? ' *' : ''}',
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade6,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: isModified,
            initialValue: value,
            style: context.textStyleTheme.b16Medium.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 8, top: 2),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: context.colorTheme.neutral.shade5,
                  width: 0.5,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(
    BuildContext context,
    String label,
    String? value,
    int maxLines,
    bool isOk, {
    void Function(String)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label.tr(context)} *',
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade6,
            ),
          ),
          const SizedBox(height: 11),
          Container(
            decoration: BoxDecoration(
              color: context.colorTheme.neutral.shade2,
              border: Border.all(
                color: isOk ? context.colorTheme.warning : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              initialValue: value,
              style: context.textStyleTheme.b16Medium.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter the message'.tr(context),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                hintStyle: context.textStyleTheme.b16Medium.copyWith(
                  color: context.colorTheme.neutral.shade6,
                ),
                border: InputBorder.none,
              ),
              maxLines: maxLines,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
