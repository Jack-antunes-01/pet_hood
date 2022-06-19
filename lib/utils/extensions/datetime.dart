extension DateTimeExt on DateTime {
  String postDate(DateTime date) {
    var postedDate = date.subtract(const Duration(hours: 3));
    var timeNow = DateTime.now();

    var seconds = ((timeNow.millisecondsSinceEpoch -
                postedDate.millisecondsSinceEpoch -
                10800000) /
            1000)
        .floor();

    var interval = (seconds / 31536000).round();

    if (interval > 1) {
      if (interval == 1) return "$interval ano atrás";
      return "$interval anos atrás";
    }
    interval = (seconds / 2592000).round();
    if (interval > 1) {
      if (interval == 1) return "$interval mês atrás";
      return "$interval meses atrás";
    }
    interval = (seconds / 86400).round();
    if (interval > 1) {
      if (interval == 1) return "$interval dia atrás";
      return "$interval dias atrás";
    }
    interval = (seconds / 3600).round();
    if (interval > 1) {
      if (interval == 1) return "$interval hora atrás";
      return "$interval horas atrás";
    }
    interval = (seconds / 60).round();
    if (interval >= 1) {
      if (interval == 1) return "$interval minuto atrás";
      return "$interval minutos atrás";
    }
    return "Agora";
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
