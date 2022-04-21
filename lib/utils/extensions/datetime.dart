extension DateTimeExt on DateTime {
  String postDate() {
    final timeNow = DateTime.now();

    final int yearDiff = timeNow.year - year;
    final int monthDiff = timeNow.month - month;
    final int dayDiff = timeNow.day - day;

    final int hourDiff = timeNow.hour - hour;
    final int minuteDiff = timeNow.minute - minute;

    if (yearDiff > 0) {
      if (yearDiff == 1) {
        return "$yearDiff ano atrás";
      }
      return "$yearDiff anos atrás";
    } else if (monthDiff > 0) {
      if (monthDiff == 1) {
        return "$monthDiff mês atrás";
      }
      return "$monthDiff meses atrás";
    } else if (dayDiff > 0) {
      if (dayDiff == 1) {
        return "$dayDiff dia atrás";
      }
      return "$dayDiff dias atrás";
    } else if (hourDiff > 0) {
      if (hourDiff == 1) {
        return "$hourDiff hora atrás";
      }
      return "$hourDiff horas atrás";
    } else if (minuteDiff > 0) {
      if (minuteDiff == 1) {
        return "$hourDiff minuto atrás";
      }
      return "$minuteDiff minutos atrás";
    } else {
      return "Agora";
    }
  }

  String toYearOrMonth() {
    final timeNow = DateTime.now();

    final int yearDiff = timeNow.year - year;
    final int monthDiff = timeNow.month - month;

    if (yearDiff > 0) {
      if (yearDiff == 1) {
        return "1 ano";
      }
      return "$yearDiff anos";
    } else {
      if (monthDiff == 1) {
        return "1 mês";
      }
      return "$monthDiff meses";
    }
  }

  bool verifyNewest() {
    final timeNow = DateTime.now();

    return timeNow.day - day < 2;
  }
}
