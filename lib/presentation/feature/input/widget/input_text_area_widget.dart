import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';

class InputTextAreaWidget extends StatelessWidget {
  const InputTextAreaWidget({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  final ValueChanged<String> onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        onChanged: onChanged,
        initialValue: initialValue,
        textInputAction: TextInputAction.done,
        scrollPadding: const EdgeInsets.only(bottom: 112),
        onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.all(19),
          hintText: 'Add any notes or details here.'.tr(context),
          hintStyle: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
          counter: const SizedBox.shrink(),
        ),
        maxLength: switch (context.locale) {
          AppLocale.en => 70,
          AppLocale.ko => 40,
        },
        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
      ),
    );
  }
}
