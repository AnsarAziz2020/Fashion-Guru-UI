String formatDateString(String dateString){
  List<String> parts = dateString.split('T');
  String datePart = parts[0];
  String timePart = parts[1];

  List<String> dateComponents = datePart.split('-');
  List<String> timeComponents = timePart.split(':');

  String year = dateComponents[0];
  String month = dateComponents[1];
  String day = dateComponents[2];

  String hour = timeComponents[0];
  String minute = timeComponents[1];
  String second = timeComponents[2].split(".")[0];
  return '$day ${monthNoToMonth(month)} $year $hour:$minute:$second';
}

String monthNoToMonth(String monthNo){
  Map<String, dynamic> months = {
    "01": "Jan",
    "02": "Feb",
    "03": "Mar",
    "04": "Apr",
    "05": "May",
    "06": "Jun",
    "07": "Jul",
    "08": "Aug",
    "09": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec",
  };
  return months[monthNo];
}