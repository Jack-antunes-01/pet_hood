final RegExp nameRegExp = RegExp(r'^[a-z]+$');

usernameValidator({String? value, required bool isEnabled}) {
  if (value != null && value.length > 4) {
    return null;
  } else {
    return "Nome de usuário deve ter pelo menos 5 caracteres";
  }
}
