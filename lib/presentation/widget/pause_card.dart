import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';
import 'package:flutter_stopwatch_timetracking/presentation/icons/custom_icons.dart';

class PauseCard extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtittle;
  final bool inFocus;
  final bool disabled;

  const PauseCard(
      {Key? key,
      required this.onTap,
      this.title = '',
      this.subtittle = '',
      this.inFocus = false,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool blur = disabled && !inFocus;

    return AbsorbPointer(
      absorbing: disabled,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 4,
            shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
            shape: RoundedRectangleBorder(
              side: inFocus
                  ? const BorderSide(
                      color: AppColors.pauseCardBorderColor,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
              leading: inFocus
                  ? null
                  : SizedBox(
                      height: double.infinity,
                      child: Icon(
                        CustomIcons.pause,
                        color: blur ? AppColors.pauseIconColor.withOpacity(0.3) : AppColors.pauseIconColor,
                        size: 28,
                      ),
                    ),
              title: Text(
                title,
                style: TextStyle(
                    fontFamily: 'AvenirNext',
                    color: blur ? AppColors.black.withOpacity(0.4) : AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.25),
              ),
              subtitle: Text(
                subtittle,
                style: const TextStyle(
                  color: AppColors.subtitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'AvenirNext',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
