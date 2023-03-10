import 'package:flutter/material.dart';

class PageLoadingAnimation extends StatelessWidget {
  const PageLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
