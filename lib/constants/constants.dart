import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m_skool_flutter/main.dart';

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List<String> fullMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<Map<String, dynamic>> fullMonthsWithIndex = [
  {
    "month": 'January',
    "day": 1,
  },
  {
    "month": 'February',
    "day": 2,
  },
  {
    "month": 'March',
    "day": 3,
  },
  {
    "month": 'April',
    "day": 4,
  },
  {
    "month": 'May',
    "day": 5,
  },
  {
    "month": 'June',
    "day": 6,
  },
  {
    "month": 'July',
    "day": 7,
  },
  {
    "month": 'August',
    "day": 8,
  },
  {
    "month": 'September',
    "day": 9,
  },
  {
    "month": 'October',
    "day": 10,
  },
  {
    "month": 'November',
    "day": 11,
  },
  {
    "month": 'December',
    "day": 12,
  },
];

List numberList = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59",
  "60",
  "61",
  "62",
  "63",
  "64",
  "65",
  "66",
  "67",
  "68",
  "69",
  "70",
  "71",
  "72",
  "73",
  "74"
];
String getFormatedDate(DateTime dt) {
  String formattedDt = "";
  if (dt.day < 10) {
    formattedDt += "0${dt.day}";
  } else {
    formattedDt += dt.day.toString();
  }

  switch (dt.month) {
    case 1:
      formattedDt += " Jan";
      break;
    case 2:
      formattedDt += " Feb";
      break;
    case 3:
      formattedDt += " Mar";
      break;
    case 4:
      formattedDt += " Apr";
      break;
    case 6:
      formattedDt += " Jun";
      break;
    case 7:
      formattedDt += " Jul";
      break;
    case 8:
      formattedDt += " Aug";
      break;
    case 9:
      formattedDt += " Sep";
      break;
    case 10:
      formattedDt += " Oct";
      break;
    case 11:
      formattedDt += " Nov";
      break;
    case 12:
      formattedDt += " Dec";
      break;
    case 5:
      formattedDt += " May";
      break;
  }
  formattedDt += " ${dt.year}";

  return formattedDt;
}

List<String> shortMonth = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

List<Color> colors = [
  Colors.green.shade100,
  Colors.redAccent.shade100,
  Colors.purpleAccent.shade100,
  Colors.pinkAccent.shade100,
  Colors.greenAccent.shade100,
  Colors.tealAccent.shade100,
  Colors.limeAccent.shade100,
  Colors.deepOrange.shade100,
];
List<Color> noticeColor = const [
  Color(0xFFF54c4c),
  Color(0xFF015DAF),
  Color(0xFF824CC3),
  Color(0xFFEC16F0),
  Color(0xFF28B6C8),
  Color(0xFFAF6152),
  Color(0xFF3FCF52),
];

List<Color> hwCwViewWorkColor = const [
  Color.fromARGB(255, 255, 202, 202),
  Color.fromARGB(255, 201, 230, 255),
  Color.fromARGB(255, 225, 200, 255),
  Color.fromARGB(255, 254, 209, 255),
  Color.fromARGB(255, 212, 250, 255),
  Color.fromARGB(255, 255, 227, 221),
  Color.fromARGB(255, 234, 255, 236),
];
List<Color> noticeBackgroundColor = const [
  Color(0xFFFFd8d8),
  Color(0xFFDFEFFD),
  Color(0xFFF1E5FF),
  Color(0xFFFFEEFF),
  Color(0xFFEEFDFF),
  Color(0xFFFFEBE7),
  Color(0xFFEFFFF1),
];

List<Color> lighterColor = const [
  Color(0xFFFFF3F3),
  Color.fromARGB(255, 232, 244, 255),
  Color.fromARGB(255, 244, 235, 255),
  Color.fromARGB(255, 255, 242, 255),
  Color(0xFFF0FEFE),
  Color.fromARGB(255, 255, 244, 242),
  Color.fromARGB(255, 237, 255, 239),
];

List<Color> examCardColor = const [
  Color.fromARGB(255, 252, 205, 255),
  Color.fromARGB(255, 243, 238, 178),
  Color.fromARGB(255, 184, 173, 233),
  Color.fromARGB(255, 161, 216, 216),
  Color.fromARGB(255, 210, 167, 223),
];
List<Color> chipColor = const [
  Color(0xFFFBCFFF),
  Color(0xFFFBF6C4),
  Color(0xFFDBC3FE),
  Color(0xFFACEFDF)
];
List<Color> textColor = const [
  Color(0xFFF000FF),
  Color(0xFFBCAE29),
  Color.fromARGB(255, 146, 73, 255),
  Color.fromARGB(255, 38, 117, 99),
  Color(0xFFE077FF),
];

List<Color> pieColor = const [
  Color(0xFFF000FF),
  Color.fromARGB(255, 255, 230, 0),
  Color.fromARGB(255, 146, 73, 255),
  Color.fromARGB(255, 38, 117, 99),
  Color(0xFFE077FF),
];

Map<String, dynamic> getMonthWithCount = {
  "1": 31,
  "3": 31,
  "4": 30,
  "5": 31,
  "6": 30,
  "7": 31,
  "8": 30,
  "9": 30,
  "10": 31,
  "11": 30,
  "12": 31,
  "2": DateTime.now().year % 4 == 0 ? 29 : 28
};

Map<String, dynamic> dayName = {
  "1": "Mon",
  "2": "Tue",
  "3": "Wed",
  "4": "Thu",
  "5": "Fri",
  "6": "Sat",
  "7": "Sun",
};

List<Color> timetablePeriodColor = const [
  Color(0xFF9900F0),
  Color(0xFF32E1F7),
  Color(0xFF4ED092),
  Color(0xFFFFE500),
  Color(0xFFFF9621),
  Color(0xFFFF60A8),
  Color(0xFFA9D252),
  Color(0xFF09B4BD),
  Color(0xFFFF6F67),
  Color.fromARGB(255, 84, 197, 19),
  Color.fromARGB(255, 12, 126, 146),
  Color.fromARGB(255, 150, 14, 127),
  Color.fromARGB(255, 114, 24, 150),
];
List<Color> timetableLightPeriodColor = const [
  Color.fromARGB(255, 232, 191, 255),
  Color.fromARGB(255, 190, 247, 255),
  Color.fromARGB(255, 195, 255, 226),
  Color.fromARGB(255, 255, 251, 216),
  Color.fromARGB(255, 255, 233, 208),
  Color.fromARGB(255, 255, 213, 232),
  Color.fromARGB(255, 241, 255, 209),
  Color.fromARGB(255, 213, 253, 255),
  Color.fromARGB(255, 255, 208, 205),
  Color.fromARGB(255, 225, 255, 207),
  Color.fromARGB(255, 206, 248, 255),
  Color.fromARGB(255, 255, 207, 247),
  Color.fromARGB(255, 243, 213, 255),
];

List<int> timetableLLPeriodColor = const [
  0xFFDBB3F3,
  0xFFB2E7EE,
  0xFF9CDDBE,
  0xFFDDD695,
  0xFFE6C6A3,
  0xFFE0A3BF,
  0xFFC9DF99,
  0xFF96DADD,
  0xFFDAA9A6,
  0xFFBCDFA8,
  0xFFAAD2DA,
  0xFFDDA8D4,
  0xFFCCA8DA,
];

List<int> ttLighterBoxColor = const [
  0xFFD7C5E2,
  0xFFB0D5DA,
  0xFFA1E7C5,
  0xFFD8D3A6,
  0xFFDAC5AE,
  0xFFE5BACD,
  0xFFD8E6BB,
  0xFFC2E9EB,
  0xFFEEC7C5,
  0xFFD7ECCA,
  0xFFC4E9F0,
  0xFFEBBDE3,
  0xFFD5B2E2,
];

List<String> timetablePdfPeriodColor = const [
  "#9900F0",
  "#32E1F7",
  "#4ED092",
  "#FFE500",
  "#FF9621",
  "#FF60A8",
  "#A9D252",
  "#09B4BD",
  "#FF6F67",
  "#54C513",
  "#0C7E92",
  "#960E7F",
  "#721896",
];
List<int> timetablePdfSubColor = const [
  0x3C9800F0,
  0x4432E0F7,
  0x524ED091,
  0x52FFE600,
  0x52FF9721,
  0x4EFF60A7,
  0x57AAD252,
  0x5209B4BD,
  0x50FF6F67,
  0x4454C513,
  0x420C7E92,
  0x36960E7F,
  0x34721896,
];

Color getDashBoardIconByName(String title) {
  switch (title) {
    case "english":
      return const Color(0xFF9900F0);
    case "kannada":
      return const Color(0xFF32E1F7);
    case "physics":
      return const Color(0xff4ED092);
    case "chemistry":
      return const Color(0XFF00b1bb);
    case "mathematics":
      return const Color(0xFFFF9621);
    case "computer science":
      return const Color(0xFFFF60A8);
    case "biology":
      return const Color(0xffFF6F67);
    case "social science":
      return const Color(0xff09B4BD);
    case "library":
      return const Color(0xffA9D252);
    case "science":
      return Colors.greenAccent[700]!;
    case "hindi":
      return const Color(0xFF015DAF);
    case "chemistry lab":
      return const Color(0xFF824CC3);
    case "commercial studies":
      return const Color(0xFFEC16F0);
    case "colouring..":
      return const Color(0xFFF54C4C);
    default:
      return Colors.grey;
  }
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second ago';
  } else {
    return 'just now';
  }
}

String convertToAgoShort(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hr';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} min';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec';
  } else {
    return 'just now';
  }
}

String getDate(DateTime dt) {
  return "${dt.day}-${dt.month}-${dt.year}";
}

String timeDifference(String fTime, String sTime) {
  logger.d(fTime);
  logger.d(sTime);

  int fHour = int.parse(fTime.split(":").first);
  int fMin = int.parse(fTime.split(":")[1]);

  int sHour = int.parse(sTime.split(":").first);
  int sMin = int.parse(sTime.split(":")[1]);

  if ((sHour == 0 && sMin == 0) || (fHour == 0 && fMin == 0)) {
    return "0 h 0 m";
  }

  DateTime fTimee = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, fHour, fMin);
  DateTime sTimee = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, sHour, sMin);
  int difference = sTimee.difference(fTimee).inMinutes;
  int hour = difference ~/ 60;
  int minute = difference % 60;

  hour = hour.abs();
  minute = minute.abs();

  return "$hour h $minute m";
}

String timing(String time) {
  if (time == "null") {
    return "N/A";
  }
  int hr = int.parse(time.split(":").first);
  int minutes = int.parse(time.split(":")[1]);
  String min = "";
  if (minutes < 10) {
    min += "0$minutes";
  } else {
    min = "$minutes";
  }
  String t = "";
  switch (hr) {
    case 12:
      t = "12:$min PM";
      break;
    case 13:
      t = "01:$min PM";
      break;
    case 14:
      t = "02:$min PM";
      break;
    case 15:
      t = "03:$min PM";
      break;

    case 16:
      t = "04:$min PM";
      break;
    case 17:
      t = "05:$min PM";
      break;

    case 18:
      t = "06:$min PM";
      break;
    case 19:
      t = "07:$min PM";
      break;
    case 20:
      t = "08:$min PM";
      break;

    case 21:
      t = "09:$min PM";
      break;
    case 22:
      t = "10:$min PM";
      break;
    case 23:
      t = "11:$min PM";
      break;

    case 00:
      t = "00:$min ";
      break;
    default:
      t = "$hr:$min AM";
      break;
  }
  return t;
}

Map<String, dynamic> getNotificationItem(String module) {
  if (module.toLowerCase() == "interaction") {
    return {
      "color": timetablePeriodColor.elementAt(0),
      "bgColor": timetableLightPeriodColor.elementAt(0),
      "image": "assets/images/tabinteraction.png",
    };
  }

  if (module.toLowerCase() == "homework") {
    return {
      "color": timetablePeriodColor.elementAt(1),
      "bgColor": timetableLightPeriodColor.elementAt(1),
      "image": "assets/images/cl.png",
    };
  }

  if (module.toLowerCase() == "classwork") {
    return {
      "color": timetablePeriodColor.elementAt(2),
      "bgColor": timetableLightPeriodColor.elementAt(2),
      "image": "assets/images/ENGLISH.png",
    };
  }
  if (module.toLowerCase() == "coe") {
    return {
      "color": timetablePeriodColor.elementAt(2),
      "bgColor": timetableLightPeriodColor.elementAt(2),
      "image": "assets/images/event.png",
    };
  }

  return {
    "color": noticeColor.elementAt(Random.secure().nextInt(6)),
    "bgColor": noticeBackgroundColor
        .elementAt(Random.secure().nextInt(6))
        .withOpacity(0.3),
    "image": "assets/images/hat.png",
  };
}

List<Color> borderColor = [
  const Color(0xFFC147E9),
  const Color(0xFF4DEEEA),
  const Color(0xFF74EE15),
  const Color(0xFFFFE700),
  const Color(0xFFF000FF),
  const Color(0xFF001EFF),
  const Color(0xFF4DEEEA),
];
List<Color> lighterColorBg = [
  const Color(0xFFFCF1FF),
  const Color(0xffEfffff),
  const Color(0xFFF5FFEE),
  const Color.fromARGB(255, 255, 253, 232),
  const Color(0xFFFEF3FF),
  const Color(0xFFF4F6FF),
  const Color.fromARGB(255, 254, 255, 255)
];
String getDayName(int dayOfWeek) {
  switch (dayOfWeek) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "Invalid day";
  }
}
