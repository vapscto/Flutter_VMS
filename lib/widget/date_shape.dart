import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*0.3103448275862069).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2657637);
    path_0.cubicTo(
        0,
        size.height * 0.2473863,
        size.width * 0.004182103,
        size.height * 0.2317881,
        size.width * 0.009824977,
        size.height * 0.2291193);
    path_0.lineTo(size.width * 0.4926023, size.height * 0.0007805444);
    path_0.cubicTo(
        size.width * 0.4936966,
        size.height * 0.0002628926,
        size.width * 0.4948092,
        size.height * 0.0002570393,
        size.width * 0.4959034,
        size.height * 0.0007631667);
    path_0.lineTo(size.width * 0.9901379, size.height * 0.2292078);
    path_0.cubicTo(size.width * 0.9957977, size.height * 0.2318237, size.width,
        size.height * 0.2474463, size.width, size.height * 0.2658696);
    path_0.lineTo(size.width, size.height * 0.7213963);
    path_0.cubicTo(
        size.width,
        size.height * 0.7397111,
        size.width * 0.9958460,
        size.height * 0.7552741,
        size.width * 0.9902264,
        size.height * 0.7580148);
    path_0.lineTo(size.width * 0.4959943, size.height * 0.9991519);
    path_0.cubicTo(
        size.width * 0.4948402,
        size.height * 0.9997148,
        size.width * 0.4936667,
        size.height * 0.9997074,
        size.width * 0.4925126,
        size.height * 0.9991296);
    path_0.lineTo(size.width * 0.009734356, size.height * 0.7581074);
    path_0.cubicTo(size.width * 0.004132621, size.height * 0.7553111, 0,
        size.height * 0.7397704, 0, size.height * 0.7215074);
    path_0.lineTo(0, size.height * 0.2657637);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff41A6AE).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
