import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFormField extends StatefulWidget {
  final Function(XFile?) onChanged;
  const ImageFormField({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<ImageFormField> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends State<ImageFormField> {
  XFile? _xFile;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    widget.onChanged(image);
    setState(() {
      _xFile = image;
    });
  }

  Widget getImageWidget() {
    return _xFile != null
        ? ImagePreview(filePath: _xFile!.path)
        : const FallbackImage();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () { _pickImage(); },
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: getImageWidget(),
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
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.filePath}) : super(key: key);

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        filePath,
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      ),
    );
  }
}


class FallbackImage extends StatelessWidget {
  const FallbackImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
        Icons.image_rounded,
        color: Colors.grey,
        size: 100
    );
  }
}

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
