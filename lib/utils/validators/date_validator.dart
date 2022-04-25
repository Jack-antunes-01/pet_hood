dateValidator({
  String? value,
  bool isNullable = false,
}) {
  if (!isNullable || value != null) {
    if (value != null && value != "") {
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
          final dateNow = DateTime.now();
          if (date.isAfter(dateNow)) {
            return "Digite uma data válida";
          }
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
}
