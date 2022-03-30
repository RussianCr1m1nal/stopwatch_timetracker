import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';


class SliverBodyRounder extends StatelessWidget {
  final Color cornerColor;
  final double radius;
  final bool sliver;

  const SliverBodyRounder({Key? key,
    this.cornerColor = AppColors.primaryColor,
    this.sliver = true,
    this.radius = 24.0,
  }) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final painter = CustomPaint(
      painter: _TopRoundPainter(cornerColor: cornerColor, radius: radius),
      size: const Size(0,1),
    );
    return _sliverWrapper(painter);
  }

  Widget _sliverWrapper(Widget child){
    if(sliver){
      return SliverToBoxAdapter(child: child,);
    } else {
      return child;
    }
  }
}

class _TopRoundPainter extends CustomPainter{
  final Color cornerColor;
  final double radius;

  _TopRoundPainter({
    required this.cornerColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cornerPaint = Paint()
      ..color = cornerColor
      ..style = PaintingStyle.fill;
    final cornerPath = Path();

    cornerPath.moveTo(0, radius);
    cornerPath.quadraticBezierTo(0, 0, radius, 0);
    cornerPath.lineTo(size.width - radius, 0);
    cornerPath.quadraticBezierTo(size.width, 0, size.width, radius);
    cornerPath.lineTo(size.width, 0);
    cornerPath.lineTo(0, 0);
    cornerPath.close();
    canvas.drawPath(cornerPath, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

