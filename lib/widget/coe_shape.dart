import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*0.6639676113360324).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class CoeShape extends CustomClipper<Path> {
  @override
  Path getClip(ui.Size size) {
    // Path path_0 = Path();
    // path_0.moveTo(size.width * 0.4635628, 0);
    // path_0.lineTo(size.width * 0.9581660, 0);
    // path_0.cubicTo(
    //     size.width * 0.9805263,
    //     0,
    //     size.width * 0.9986518,
    //     size.height * 0.02729970,
    //     size.width * 0.9986518,
    //     size.height * 0.06097561);
    // path_0.lineTo(size.width * 0.9986518, size.height * 0.9390244);
    // path_0.cubicTo(
    //     size.width * 0.9986518,
    //     size.height * 0.9727012,
    //     size.width * 0.9805263,
    //     size.height,
    //     size.width * 0.9581660,
    //     size.height);
    // path_0.lineTo(0, size.height);
    // path_0.lineTo(size.width * 0.4635628, 0);
    // path_0.close();
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3483019, size.height * 0.03332585);
    path_0.cubicTo(
        size.width * 0.3528842,
        size.height * 0.02043598,
        size.width * 0.3627493,
        size.height * 0.01219512,
        size.width * 0.3735967,
        size.height * 0.01219512);
    path_0.lineTo(size.width * 0.9674419, size.height * 0.01219512);
    path_0.cubicTo(
        size.width * 0.9828558,
        size.height * 0.01219512,
        size.width * 0.9953488,
        size.height * 0.02857494,
        size.width * 0.9953488,
        size.height * 0.04878049);
    path_0.lineTo(size.width * 0.9953488, size.height * 0.9634146);
    path_0.cubicTo(
        size.width * 0.9953488,
        size.height * 0.9836220,
        size.width * 0.9828558,
        size.height,
        size.width * 0.9674419,
        size.height);
    path_0.lineTo(size.width * 0.04844605, size.height);
    path_0.cubicTo(
        size.width * 0.02803493,
        size.height,
        size.width * 0.01452907,
        size.height * 0.9722134,
        size.width * 0.02315126,
        size.height * 0.9479573);
    path_0.lineTo(size.width * 0.3483019, size.height * 0.03332585);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    // canvas.drawPath(path_0, paint_0_fill);

    // Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    // paint_1_fill.color = Color(0xffDADADA).withOpacity(1.0);
    // canvas.drawRect(
    //     Rect.fromLTWH(
    //         size.width * -0.1503860, 0, size.width * 1.147288, size.height),
    //     paint_1_fill);

    // Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    // paint_0_fill.color = Colors.white.withOpacity(1.0);
    //canvas.drawPath(path_0, paint_0_fill);
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
