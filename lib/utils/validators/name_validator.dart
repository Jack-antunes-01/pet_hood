nameValidator({String? value, required bool isEnabled}) {
  var arr = value.toString().split(" ");
  if (isEnabled &&
      value != null &&
      ((arr.length < 2 || arr.length > 1 && arr[1].isEmpty) ||
          value.length < 4)) {
    return "Digite seu nome completo";
  } else {
    return null;
  }
}
