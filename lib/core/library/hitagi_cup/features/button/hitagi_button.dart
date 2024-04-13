import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';

class HitagiButton extends TextButton {
  final String label;
  final Color? corButton;
  final Color? corTexto;
  final EdgeInsetsGeometry padding;
  final double? elevation;
  final HitagiTypography typography;

  HitagiButton({
    super.key,
    required this.label,
    required super.onPressed,
    this.corButton,
    this.corTexto,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    this.elevation,
    this.typography = HitagiTypography.button,
  }) : super(
          child: HitagiText(
            text: label,
            typography: typography,
            color: corTexto ?? Colors.black,
          ),
          style: TextButton.styleFrom(
            elevation: elevation,
            backgroundColor: corButton ?? const Color.fromARGB(188, 241, 145, 145),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: padding,
          ),
        );
  HitagiButton.icon({
    super.key,
    required this.label,
    required super.onPressed,
    this.corButton,
    this.corTexto,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    this.elevation,
    this.typography = HitagiTypography.button,
    required IconData icon,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HitagiText(
                text: label,
                typography: typography,
                color: corTexto ?? Colors.white,
              ),
              const SizedBox(width: 6),
              Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
          style: TextButton.styleFrom(
            elevation: elevation,
            backgroundColor: corButton ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: padding,
          ),
        );
}
