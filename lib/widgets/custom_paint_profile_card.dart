import 'package:flutter/material.dart';

class CustomPaintProfileCard extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_0 = Path();
    path_0.moveTo(size.width*0.0025510,size.height*0.0611111);
    path_0.lineTo(size.width*0.0051020,size.height*0.0444444);
    path_0.lineTo(size.width*0.0076531,size.height*0.0277778);
    path_0.lineTo(size.width*0.0102041,size.height*0.0166667);
    path_0.lineTo(size.width*0.0229592,size.height*0.0055556);
    path_0.lineTo(size.width*0.0331633,0);
    path_0.lineTo(size.width*0.5790816,0);
    path_0.lineTo(size.width*0.5892857,0);
    path_0.lineTo(size.width*0.5943878,size.height*0.0111111);
    path_0.lineTo(size.width*0.6020408,size.height*0.0222222);
    path_0.lineTo(size.width*0.6096939,size.height*0.0277778);
    path_0.lineTo(size.width*0.6173469,size.height*0.0500000);
    path_0.lineTo(size.width*0.6198980,size.height*0.0833333);
    path_0.lineTo(size.width*0.6250000,size.height*0.2444444);
    path_0.lineTo(size.width*0.6250000,size.height*0.2722222);
    path_0.lineTo(size.width*0.6250000,size.height*0.2944444);
    path_0.lineTo(size.width*0.6326531,size.height*0.3055556);
    path_0.lineTo(size.width*0.6403061,size.height*0.3166667);
    path_0.lineTo(size.width*0.6479592,size.height*0.3277778);
    path_0.lineTo(size.width*0.6581633,size.height*0.3333333);
    path_0.lineTo(size.width*0.6658163,size.height*0.3333333);
    path_0.lineTo(size.width*0.9591837,size.height*0.3388889);
    path_0.lineTo(size.width*0.9744898,size.height*0.3388889);
    path_0.lineTo(size.width*0.9795918,size.height*0.3444444);
    path_0.lineTo(size.width*0.9872449,size.height*0.3555556);
    path_0.lineTo(size.width*0.9897959,size.height*0.3722222);
    path_0.lineTo(size.width*0.9974490,size.height*0.4111111);
    path_0.lineTo(size.width*0.9974490,size.height*0.9388889);
    path_0.lineTo(size.width,size.height*0.9666667);
    path_0.lineTo(size.width*0.9974490,size.height*0.9777778);
    path_0.lineTo(size.width*0.9923469,size.height*0.9888889);
    path_0.lineTo(size.width*0.9795918,size.height*0.9944444);
    path_0.lineTo(size.width*0.9770408,size.height);
    path_0.lineTo(size.width*0.0306122,size.height);
    path_0.lineTo(size.width*0.0229592,size.height);
    path_0.lineTo(size.width*0.0127551,size.height*0.9888889);
    path_0.lineTo(size.width*0.0051020,size.height*0.9777778);
    path_0.lineTo(size.width*0.0025510,size.height*0.9666667);
    path_0.lineTo(0,size.height*0.9333333);
    path_0.lineTo(size.width*0.0025510,size.height*0.0611111);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);


    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;



    canvas.drawPath(path_0, paint_stroke_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
