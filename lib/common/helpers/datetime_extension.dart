extension DateTimeExtensions on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isThisWeek() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    return isAfter(firstDayOfWeek) && isBefore(lastDayOfWeek);
  }

  bool isThisMonth() {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
}
