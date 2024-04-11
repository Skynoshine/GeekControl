import 'package:flutter/material.dart';

enum HitagiTypography {
  giga(true, 33),
  title(true, 20),
  button(true, 16),
  body(false, 17);

  final bool isBold;
  final double size;
  const HitagiTypography(this.isBold, this.size);
}

class HitagiText extends StatelessWidget {
  final String text;
  final HitagiTypography typography;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? maskFilter;
  final TextAlign? textAlign;

  const HitagiText({
    super.key,
    required this.text,
    this.typography = HitagiTypography.body,
    this.color,
    this.maxLines,
    this.overflow,
    this.maskFilter,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_class_text
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: typography.size,
            fontWeight: typography.isBold ? FontWeight.bold : FontWeight.normal,
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..color = color ?? Colors.black
              ..maskFilter = MaskFilter.blur(
                BlurStyle.normal,
                maskFilter ?? 0,
              ),
          ),
      textAlign: textAlign,
    );
  }
}
