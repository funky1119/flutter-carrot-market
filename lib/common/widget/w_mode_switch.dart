import 'package:flutter/material.dart';

import '../../../common/common.dart';

class ModeSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double height;
  final Color activeThumbColor;
  final Image? activeThumbImage;
  final Color inactiveThumbColor;
  final Image? inactiveThumbImage;

  const ModeSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.height,
    this.activeThumbColor = Colors.white,
    this.activeThumbImage,
    this.inactiveThumbColor = Colors.white,
    this.inactiveThumbImage,
  }) : super(key: key);

  @override
  State<ModeSwitch> createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {
  final duration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    const aspectRatio = (40 / 25);
    return Tap(
      onTap: () => widget.onChanged(!widget.value),
      child: Row(
        children: [
          Text(
            'Light',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: widget.value
                  ? context.appColors.inActivate
                  : context.appColors.activate,
            ),
          ),
          const Width(5),
          SizedBox(
            height: widget.height,
            width: aspectRatio * widget.height,
            child: Stack(
              children: [
                AnimatedContainer(
                  decoration: BoxDecoration(
                      color: widget.value
                          ? const Color.fromARGB(255, 0, 9, 27)
                          : const Color.fromARGB(255, 106, 158, 255),
                      borderRadius: BorderRadius.circular(widget.height / 2)),
                  duration: duration,
                ),
                AnimatedContainer(
                  duration: duration,
                  padding: EdgeInsets.symmetric(
                      horizontal: (2 / 25) * widget.height),
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: widget.value ? 1.0 : 0.0,
                        child: Container(
                          height: (3 / 4) * widget.height,
                          width: (3 / 4) * widget.height,
                          decoration: BoxDecoration(
                            color: widget.activeThumbColor,
                          ),
                          child: widget.activeThumbImage,
                        ),
                      ),
                      Opacity(
                        opacity: widget.value ? 0.0 : 1.0,
                        child: Container(
                          height: (3 / 4) * widget.height,
                          width: (3 / 4) * widget.height,
                          decoration: BoxDecoration(
                            color: widget.inactiveThumbColor,
                          ),
                          child: widget.inactiveThumbImage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Width(5),
          Text(
            'Dark',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: widget.value
                  ? context.appColors.activate
                  : context.appColors.inActivate,
            ),
          )
        ],
      ),
    );
  }
}
