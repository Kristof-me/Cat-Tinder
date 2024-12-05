import 'dart:math';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  final double maxWidth = 600;
  final double columnScale = 0.8;
  // compared to column width or window height
  final double imageScale = 0.6; 

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = min(maxWidth, size.width * columnScale);
    final double imageSize = min(width * imageScale, size.height * imageScale);


    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/icon.png', width: imageSize, height: imageSize),
                SizedBox(height: 50),
                LinearProgressIndicator(minHeight: 10),
                Text('Loading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
