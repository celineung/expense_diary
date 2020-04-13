
class DateUtils {
  static String toDateStr(DateTime dateTime) {
    if (dateTime == null) return "";
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2,'0');
    String day = dateTime.day.toString().padLeft(2,'0');
    return '${day}/${month}/${year}';
  }
}
