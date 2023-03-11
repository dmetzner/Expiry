import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image/upload_icon.dart';

class ImageFormField extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;
  const ImageFormField({Key? key, required this.onChanged, this.initialValue}) : super(key: key);

  @override
  State<ImageFormField> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends State<ImageFormField> {
  String? imageBase64;
  static const double _width = 100;
  static const double _height = 100;

  @override
  void initState() {
    super.initState();
    imageBase64 = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _pickImage();
      },
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: _width,
                height: _height,
                child: _getImagePreviewWidget(),
              ),
              const Positioned(
                bottom: 5,
                left: 5,
                child: UploadIcon(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 250, maxHeight: 250, imageQuality: 90);
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    Uint8List? imageBytes = await imageFile?.readAsBytes();
    imageBase64 = base64Encode(imageBytes!);
    widget.onChanged(imageBase64);
    setState(() {
      imageBase64 = imageBase64;
    });
  }

  Widget _getImagePreviewWidget() {
    if (_hasValidBase64Image()) {
      return ClipRRect(borderRadius: BorderRadius.circular(8), child: _loadImageFromMemory(base64Decode(imageBase64!)));
    } else {
      return const Icon(Icons.image_rounded, color: Colors.grey, size: 100);
    }
  }

  bool _hasValidBase64Image() {
    if (imageBase64 == null || imageBase64!.isEmpty) {
      return false;
    }
    try {
      base64Decode(imageBase64!);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _loadImageFromNetwork(String filePath) {
    return Image.network(
      filePath,
      fit: BoxFit.cover,
      width: _width,
      height: _height,
    );
  }

  Widget _loadImageFromMemory(Uint8List base64ImageByeList) {
    return Image.memory(
      base64ImageByeList,
      fit: BoxFit.cover,
      width: _width,
      height: _height,
    );
  }
}
