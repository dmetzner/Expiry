import 'package:expiry/Item/Form/FormData.dart';

class FormSubmitHandler {
  void submit(FormData formData) {
    print('Submitting form data: ${formData.barCode}, ${formData.name}, ${formData.description}, ${formData.expiryDate}, ${formData.image}');
  }
}