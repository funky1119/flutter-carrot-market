import 'package:flutter/material.dart';

import '../common.dart';
import 'theme_text_badge.dart';

export 'theme_text_badge.dart';

class TextBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final BoxBorder? boder;
  final Widget? rightWidget;
  final void Function()? onTap;

  static Color defaultBorderProvider() => Colors.transparent;

  const TextBadge({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 12,
    this.borderRadius = 8,
    this.verticalPadding = 5,
    this.horizontalPadding = 6,
    this.rightWidget,
    this.onTap,
    this.boder,
  }) : super(key: key);

  TextBadge.theme(
    TextBadgeTheme theme, {
    super.key,
    required this.text,
    double? fontSize,
    this.rightWidget,
    this.onTap,
  })  : backgroundColor = theme.backgroundColor,
        textColor = theme.textColor,
        fontSize = fontSize ?? theme.fontSize,
        borderRadius = theme.borderRadius,
        verticalPadding = theme.verticalPadding,
        horizontalPadding = theme.horizontalPadding,
        boder = theme.borderWidth == null
            ? null
            : Border.all(width: theme.borderWidth!, color: theme.borderColor);

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? badge()
        : Tap(
            onTap: onTap!,
            child: badge(),
          );
  }

  Container badge() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: boder),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500, // medium
                color: textColor,
              ),
            ),
            if (rightWidget != null) rightWidget!,
          ],
        ));
  }
}
