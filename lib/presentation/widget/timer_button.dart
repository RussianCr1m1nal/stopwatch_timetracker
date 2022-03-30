import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';

class TimerButton extends StatelessWidget {
  final Function()? onPressed;
  final Color color;
  final Color? disabledColor;
  final Icon icon;
  final String text;
  final bool disabled;

  const TimerButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.icon,
      required this.text,
      required this.disabled,
      this.disabledColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(48),
            color: disabled ? disabledColor : color,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          height: 64,
          width: 156,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: icon,              
              ),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
