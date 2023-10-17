import 'dart:ui';
import 'package:flutter/material.dart';

class CustomPaintProfileCard extends CustomPainter {

@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(size.width*0.6582404,0);
path_0.lineTo(size.width*0.06517696,0);
path_0.cubicTo(size.width*0.04540811,0,size.width*0.005870541,size.height*0.02253375,size.width*0.005870541,size.height*0.1126688);
path_0.lineTo(size.width*0.005870484,size.height*0.9150685);
path_0.cubicTo(size.width*0.01066856,size.height*0.9602740,size.width*0.01853229,size.height*0.9739726,size.width*0.08179246,size.height*0.9739726);
path_0.lineTo(size.width*0.9154125,size.height*0.9739726);
path_0.cubicTo(size.width*0.9380043,size.height*0.9707068,size.width*0.9943101,size.height*1.001666,size.width*0.9943101,size.height*0.9232877);
path_0.lineTo(size.width*0.9943101,size.height*0.4933644);
path_0.cubicTo(size.width*0.9943101,size.height*0.4086438,size.width*0.9854495,size.height*0.3064822,size.width*0.9154125,size.height*0.3064822);
path_0.lineTo(size.width*0.8429445,size.height*0.3064822);
path_0.cubicTo(size.width*0.8235334,size.height*0.3064822,size.width*0.7934950,size.height*0.3064822,size.width*0.7627127,size.height*0.2815671);
path_0.cubicTo(size.width*0.7485932,size.height*0.2701356,size.width*0.7148336,size.height*0.2267477,size.width*0.7187155,size.height*0.09966932);
path_0.cubicTo(size.width*0.7203898,size.height*0.04485123,size.width*0.6954225,0,size.width*0.6582404,0);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Colors.white.withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}