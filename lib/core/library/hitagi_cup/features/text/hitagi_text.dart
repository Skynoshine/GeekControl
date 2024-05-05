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
  final double? size;
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
  final bool? isBold;
  final bool? softWrap;

  const HitagiText({
    super.key,
    required this.text,
    this.typography = HitagiTypography.body,
    this.color,
    this.isBold,
    this.softWrap,
    this.size,
    this.maxLines,
    this.overflow,
    this.maskFilter,
    this.textAlign,
    this.icon,
    this.iconSize,
    this.iconPosition = IconPosition.left,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (icon != null && iconPosition == IconPosition.left) {
      children.add(Icon(
        icon,
        size: iconSize ?? typography.size,
        color: iconColor,
      ));
      children.add(const SizedBox(width: 4));
    }

    children.add(
      Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: size ?? typography.size,
              fontWeight: isBold ?? typography.isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = color ?? Colors.black
                ..maskFilter = MaskFilter.blur(
                  BlurStyle.normal,
                  maskFilter ?? 0,
                ),
            ),
        textAlign: textAlign,
        softWrap: softWrap ?? true,
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

  factory HitagiText.icon(String text, IconData icon,
      {Color? iconColor,
      double? iconSize,
      IconPosition iconPosition = IconPosition.left}) {
    return HitagiText(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      iconColor: iconColor,
      iconSize: iconSize,
    );
  }
}
