import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 5:50 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SeekToWidget extends StatefulWidget {
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;
  final Function(double value)? onChange;
  final double value;

  const SeekToWidget(
      {Key? key,
      this.onDragStart,
      this.onDragEnd,
      this.onDragUpdate,
      this.onChange,
      required this.value})
      : super(key: key);

  @override
  _SeekWidgetState createState() => _SeekWidgetState();
}

class _SeekWidgetState extends State<SeekToWidget> {
  double _value = 0;

  @override
  void initState() {
    setState(() {
      _value = widget.value;
    });
    super.initState();
  }

  void seekToRelativePosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    if (relative >= 0 && relative <= 1) {
      _value = relative;
      if (widget.onChange != null) {
        widget.onChange!(relative);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Container(
          height: 30,
          width: 300,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _ProgressBarPainter(
              _value,
            ),
          ),
        ),
      ),
      onHorizontalDragStart: (DragStartDetails details) {
        if (widget.onDragStart != null) {
          widget.onDragStart!();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        seekToRelativePosition(details.globalPosition);
        if (widget.onDragUpdate != null) {
          widget.onDragUpdate!();
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (widget.onDragEnd != null) {
          widget.onDragEnd!();
        }
      },
      onTapDown: (TapDownDetails details) {
        seekToRelativePosition(details.globalPosition);
      },
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  _ProgressBarPainter(
    this.value,
  );

  double value;

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final height = 4.0;
    Paint paint = Paint();
    paint.color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(size.width, size.height / 2 + height),
        ),
        const Radius.circular(4.0),
      ),
      paint,
    );
    paint.color = Colors.red;
    final double playedPart = value > 1 ? size.width : value * size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(playedPart, size.height / 2 + height),
        ),
        Radius.circular(4.0),
      ),
      paint,
    );
    Path path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(playedPart, size.height / 2 + height / 2),
          radius: height * 3 + 1));
    canvas.drawShadow(path, Colors.black26, 1, true);
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(playedPart, size.height / 2 + height / 2),
      height * 3,
      paint,
    );
  }
}
