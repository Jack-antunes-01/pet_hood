birthDateValidator({String? value, required bool isEnabled}) {
  if (isEnabled && value != null) {
    final components = value.split("/");
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null &&
          month != null &&
          year != null &&
          year.toString().length == 4) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
        return "Digite uma data válida";
      }
      return "Digite uma data válida";
    }
    return "Digite uma data válida";
  }
}
