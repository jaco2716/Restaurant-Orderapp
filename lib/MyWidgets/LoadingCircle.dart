import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final Color color;
  LoadingCircle({this.color = Colors.blue});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          backgroundColor: color,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
