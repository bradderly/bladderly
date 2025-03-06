import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileNameInputField extends StatefulWidget {
  const ProfileNameInputField({
    super.key,
    required this.value,
    this.onSubmit,
  });

  final ValueChanged<String>? onSubmit;
  final String value;

  @override
  State<ProfileNameInputField> createState() => _ProfileNameInputFieldState();
}

class _ProfileNameInputFieldState extends State<ProfileNameInputField> {
  late final _focusNode = FocusNode()..addListener(_onFocusChanged);
  late final _textEditingController = TextEditingController(text: widget.value);

  late String value = widget.value;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && value != widget.value) {
      widget.onSubmit?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferred Name'.tr(context),
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade6,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.colorTheme.neutral.shade5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => this.value = value,
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Gap(16),
                GestureDetector(
                  onTap: () => _textEditingController.text = '',
                  child: Assets.icon.icExportClose
                      .svg(colorFilter: ColorFilter.mode(context.colorTheme.neutral.shade6, BlendMode.srcIn)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
