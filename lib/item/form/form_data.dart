class FormData {
  String? id;
  String barCode = '';
  String name = '';
  String description = '';
  DateTime expiryDate = DateTime.now();
  String image = '';

  void setID(String id) {
    this.id = id;
  }

  void setBarCode(String? value) {
    barCode = value ?? '';
  }

  void setName(String? value) {
    name = value!;
  }

  void setDescription(String? value) {
    description = value ?? '';
  }

  void setExpiryDate(DateTime? value) {
    expiryDate = value!;
  }

  void setImage(String? value) {
    image = value ?? '';
  }
}
