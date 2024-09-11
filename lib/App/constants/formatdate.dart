class FormatDate {
  // Private constructor to prevent instantiation
  FormatDate._();

  static String formatDateOnly(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    return '$month $day, $year';
  }

  static String _getMonthName(int month) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
