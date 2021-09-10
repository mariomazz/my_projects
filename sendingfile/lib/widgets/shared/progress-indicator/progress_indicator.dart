import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({Key? key, this.progressIndicator})
      : super(key: key) {
    progressIndicator == null
        ? progressIndicator = GradientProgressIndicator(
            duration: 2,
            radius: 80,
            strokeWidth: 12,
            gradientStops: const [
              0.2,
              0.8,
            ],
            gradientColors: const [
              Colors.white,
              Colors.grey,
            ],
            child: Container(),
          )
        : progressIndicator = progressIndicator;
  }

  GradientProgressIndicator? progressIndicator;

  @override
  Widget build(BuildContext context) {
    return circularProgressindicator();
  }

  Widget circularProgressindicator() {
    return Center(
      child: progressIndicator,
    );
  }
}
