confirmPasswordValidator({
  required bool isEnabled,
  required String password,
  required String confirmPassword,
}) {
  if (!isEnabled || password == confirmPassword) {
    return null;
  } else {
    return "Senhas não coincidem";
  }
}
