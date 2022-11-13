import 'package:flutter/cupertino.dart';
import 'package:temp/presentation/styles/colors.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width*0.0081633,size.height*0.2160000);
    path0.quadraticBezierTo(size.width*0.0081633,size.height*0.7560000,size.width*0.0081633,size.height*0.9360000);
    path0.quadraticBezierTo(size.width*0.0091837,size.height*0.9913333,size.width*0.0489796,size.height*0.9893333);
    path0.lineTo(size.width*0.2734694,size.height*0.9893333);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.9893333,size.width*0.3142857,size.height*0.9360000);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.9093333,size.width*0.3142857,size.height*0.8720000);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.8320000,size.width*0.3551020,size.height*0.8293333);
    path0.cubicTo(size.width*0.4265306,size.height*0.8293333,size.width*0.5632653,size.height*0.8293333,size.width*0.6408163,size.height*0.8293333);
    path0.quadraticBezierTo(size.width*0.6775510,size.height*0.8320000,size.width*0.6816327,size.height*0.8720000);
    path0.quadraticBezierTo(size.width*0.6816327,size.height*0.9093333,size.width*0.6816327,size.height*0.9360000);
    path0.quadraticBezierTo(size.width*0.6816327,size.height*0.9893333,size.width*0.7224490,size.height*0.9893333);
    path0.lineTo(size.width*0.9469388,size.height*0.9893333);
    path0.quadraticBezierTo(size.width*0.9877551,size.height*0.9893333,size.width*0.9877551,size.height*0.9360000);
    path0.quadraticBezierTo(size.width*0.9877551,size.height*0.7560000,size.width*0.9877551,size.height*0.2160000);
    path0.quadraticBezierTo(size.width*0.9877551,size.height*0.1626667,size.width*0.9469388,size.height*0.1626667);
    path0.cubicTo(size.width*0.8908163,size.height*0.1626667,size.width*0.7785714,size.height*0.1626667,size.width*0.7224490,size.height*0.1626667);
    path0.quadraticBezierTo(size.width*0.6816327,size.height*0.1626667,size.width*0.6816327,size.height*0.1093333);
    path0.quadraticBezierTo(size.width*0.6816327,size.height*0.0893333,size.width*0.6816327,size.height*0.0826667);
    path0.quadraticBezierTo(size.width*0.6816327,size.height*0.0546667,size.width*0.6408163,size.height*0.0026667);
    path0.lineTo(size.width*0.3551020,size.height*0.0026667);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.0546667,size.width*0.3142857,size.height*0.0826667);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.0893333,size.width*0.3142857,size.height*0.1093333);
    path0.quadraticBezierTo(size.width*0.3142857,size.height*0.1626667,size.width*0.2734694,size.height*0.1626667);
    path0.cubicTo(size.width*0.2173469,size.height*0.1626667,size.width*0.1051020,size.height*0.1626667,size.width*0.0489796,size.height*0.1626667);
    path0.quadraticBezierTo(size.width*0.0081633,size.height*0.1626667,size.width*0.0081633,size.height*0.2160000);
    path0.close();

    canvas.drawPath(path0, paint0);


    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    }

    }
