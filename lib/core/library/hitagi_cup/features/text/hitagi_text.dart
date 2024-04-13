import 'package:flutter/material.dart';

enum HitagiTypography {
  giga(true, 28),
  title(true, 20),
  button(true, 16),
  body(false, 17);

  final bool isBold;
  final double size;
  const HitagiTypography(this.isBold, this.size);
}

enum IconPosition {
  left,
  right,
}

class HitagiText extends StatelessWidget {
  final String text;
  final HitagiTypography typography;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? maskFilter;
  final TextAlign? textAlign;
  final IconData? icon;
  final double? iconSize;
  final IconPosition? iconPosition;
  final Color? iconColor;

  const HitagiText({
    Key? key,
    required this.text,
    this.typography = HitagiTypography.body,
    this.color,
    this.maxLines,
    this.overflow,
    this.maskFilter,
    this.textAlign,
    this.icon,
    this.iconSize,
    this.iconPosition = IconPosition.left,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (icon != null && iconPosition == IconPosition.left) {
      children.add(Icon(
        icon,
        size: iconSize ?? typography.size,
        color: iconColor,
      ));
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: typography.size,
              fontWeight:
                  typography.isBold ? FontWeight.bold : FontWeight.normal,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = color ?? Colors.black
                ..maskFilter = MaskFilter.blur(
                  BlurStyle.normal,
                  maskFilter ?? 0,
                ),
            ),
        textAlign: textAlign,
      ),
    );

    if (icon != null && iconPosition == IconPosition.right) {
      children.add(const SizedBox(width: 8));
      children.add(Icon(icon, size: iconSize ?? typography.size));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }
}
