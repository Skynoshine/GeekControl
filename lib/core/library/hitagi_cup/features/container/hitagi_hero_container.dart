import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HitagiHero extends Hero {
  HitagiHero({
    Key? key,
    String? tag,
    Widget? child,
    String? image,
    String? text,
    TextStyle? style,
  }) : super(
          key: key,
          tag: tag ?? image ?? dotenv.env['DEFAULT_BANNER'].toString(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Image.network(
                          image ?? dotenv.env['DEFAULT_BANNER'].toString()),
                      const SizedBox(height: 8),
                      Text(
                        text ?? '',
                        style: style ??
                            const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      child ?? const SizedBox(),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
