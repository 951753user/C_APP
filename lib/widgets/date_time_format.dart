import 'package:intl/intl.dart';

void dateTimeFormat(String startDate,String endDate){
  var ds = DateTime.fromMillisecondsSinceEpoch(int.parse(
      startDate));
  var de = DateTime.fromMillisecondsSinceEpoch(int.parse(
      endDate));
  var dfsm = DateFormat('MM').format(ds);
  var dfem = DateFormat('MM').format(de);
  var dfsd = DateFormat('dd').format(ds);
  var dfed = DateFormat('dd').format(de);

  startMonth(dfsm);
  endMonth(dfem);

}

String? startMonthName;
String? endMonthName;

startMonth(String name) {
  switch (name) {
    case "01":
      startMonthName = "Jan";
      break;
    case "02":
      startMonthName = "Feb";
      break;
    case "03":
      startMonthName = "Mar";
      break;
    case "04":
      startMonthName = "Apr";
      break;
    case "05":
      startMonthName = "May";
      break;
    case "06":
      startMonthName = "Jun";
      break;
    case "07":
      startMonthName = "Jul";
      break;
    case "08":
      startMonthName = "Aug";
      break;
    case "09":
      startMonthName = "Sep";
      break;
    case "10":
      startMonthName = "Oct";
      break;
    case "11":
      startMonthName = "Nov";
      break;
    case "12":
      startMonthName = "Dec";
      break;
  }
}
endMonth(String name) {
  switch (name) {
    case "01":
      endMonthName = "Jan";
      break;
    case "02":
      endMonthName = "Feb";
      break;
    case "03":
      endMonthName = "Mar";
      break;
    case "04":
      endMonthName = "Apr";
      break;
    case "05":
      endMonthName = "May";
      break;
    case "06":
      endMonthName = "Jun";
      break;
    case "07":
      endMonthName = "Jul";
      break;
    case "08":
      endMonthName = "Aug";
      break;
    case "09":
      endMonthName = "Sep";
      break;
    case "10":
      endMonthName = "Oct";
      break;
    case "11":
      endMonthName = "Nov";
      break;
    case "12":
      endMonthName = "Dec";
      break;
  }
}