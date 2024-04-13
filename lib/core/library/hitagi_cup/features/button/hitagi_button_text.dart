import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';


class HitagiButtonText extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final IconData? prefix;
  final IconData? suffix;
  final HitagiTypography? typography;

  const HitagiButtonText({
    super.key,
    this.onPressed,
    required this.text,
    this.padding,
    this.color,
    this.prefix,
    this.suffix,
    this.typography,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          children: [
            prefix != null
                ? Icon(prefix, color: color)
                : const SizedBox.shrink(),
            prefix != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
            HitagiText(
              text: text,
              typography: typography ?? HitagiTypography.body,
              color: color,
            ),
            prefix != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
            suffix != null
                ? Icon(suffix, color: color)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
