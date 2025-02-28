import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/widget/ripple_button.dart';
import 'package:flutter/material.dart';

abstract class PrimaryButton extends StatelessWidget {
  const PrimaryButton._({
    super.key,
    required this.backgroundColor,
    required this.borderRadius,
    required this.shape,
    required this.text,
    required this.textColor,
    this.size,
    this.onPressed,
    this.borderColor,
    this.borderWidth,
  });

  const factory PrimaryButton.filled({
    Key? key,
    VoidCallback? onPressed,
    required Color backgroundColor,
    required double borderRadius,
    required BoxShape shape,
    required String text,
    required Color textColor,
    Size? size,
  }) = _PrimaryButtonFilled;

  const factory PrimaryButton.outlined({
    Key? key,
    VoidCallback? onPressed,
    required Color backgroundColor,
    required double borderRadius,
    required BoxShape shape,
    required String text,
    required Color textColor,
    required Color borderColor,
    required double borderWidth,
    Size? size,
  }) = _PrimaryButtonOutlined;

  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double borderRadius;
  final BoxShape shape;
  final String text;
  final Color textColor;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: RippleButton(
        onTap: onPressed,
        boxDecoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: _boxBorder,
          shape: shape,
        ),
        child: Text(
          text,
          style: context.textStyleTheme.b16SemiBold.copyWith(color: textColor),
        ),
      ),
    );
  }

  BoxBorder? get _boxBorder;
}

class _PrimaryButtonFilled extends PrimaryButton {
  const _PrimaryButtonFilled({
    super.key,
    super.onPressed,
    required super.backgroundColor,
    required super.borderRadius,
    required super.shape,
    required super.text,
    required super.textColor,
    super.size,
  }) : super._();

  @override
  BoxBorder? get _boxBorder => null;
}

class _PrimaryButtonOutlined extends PrimaryButton {
  const _PrimaryButtonOutlined({
    super.key,
    super.onPressed,
    required super.backgroundColor,
    required super.borderRadius,
    required super.shape,
    required super.text,
    required super.textColor,
    required Color super.borderColor,
    required double super.borderWidth,
    super.size,
  }) : super._();

  @override
  BoxBorder? get _boxBorder => Border.all(color: borderColor!, width: borderWidth!);
}
