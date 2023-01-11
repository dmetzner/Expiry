import 'package:image_picker/image_picker.dart';

class FormData {
  String barCode = '';
  String name = '';
  String description = '';
  DateTime expiryDate = DateTime.now();
  XFile? image;

  void setBarCode(String? value) {
    barCode = value!;
  }

  void setName(String? value) {
    name = value!;
  }

  void setDescription(String? value) {
    description = value!;
  }

  void setExpiryDate(DateTime? value) {
    expiryDate = value!;
  }

  void setImage(XFile? value) {
    image = value;
  }
}