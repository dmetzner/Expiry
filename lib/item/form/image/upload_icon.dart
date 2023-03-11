import 'package:flutter/material.dart';

class UploadIcon extends StatelessWidget {
  const UploadIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: const Icon(
            Icons.photo_camera_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
