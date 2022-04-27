import 'package:email_validator/email_validator.dart';

emailValidator({String? value, required bool isEnabled}) {
  if (isEnabled && value != null && !EmailValidator.validate(value)) {
    return "Digite um email válido";
  }
  return null;
}
