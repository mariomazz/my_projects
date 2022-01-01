import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

// ignore: must_be_immutable
class MyCircularProgressIndicator extends StatefulWidget {
  MyCircularProgressIndicator({
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.loadingColor,
    required this.borderColor,
  }) : super(key: key);

  Color? loadingColor;
  Duration duration;
  Color borderColor;

  @override
  State<MyCircularProgressIndicator> createState() =>
      _MyCircularProgressIndicatorState();
}

class _MyCircularProgressIndicatorState
    extends State<MyCircularProgressIndicator> {
  double percent = 0.0;
  Timer? timer;

  @override
  void initState() {
    final loadingTime = ((widget.duration.inMilliseconds - 200) * 1) / 100;

    timer =
        Timer.periodic(Duration(milliseconds: loadingTime.floor()), (value) {
      setState(() {
        percent += 1;
        if (percent >= 100) {
          timer!.cancel();
          // percent=0;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: LiquidCircularProgressIndicator(
        value: percent / 100,
        valueColor: widget.loadingColor != null
            ? AlwaysStoppedAnimation(widget.loadingColor!)
            : null,
        backgroundColor: Colors.white,
        borderColor: widget.borderColor,
        borderWidth: 4.0,
        direction: Axis.vertical,
        center: Text(
          percent.toString() + "%",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
