import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  // Fri, 10 Sep
  static String dayDateMonth(DateTime dateTime) {
    return DateFormat('E, dd MMM').format(dateTime);
  }

  static String dayDateMonthYear(DateTime dateTime) {
    return DateFormat('E, dd MMMM yyyy').format(dateTime);
  }

  static String fulDayDateMonthYear(DateTime dateTime) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(dateTime);
  }

  static String dayDateSMonthYear(DateTime dateTime) {
    return DateFormat('E, dd MMM yyyy').format(dateTime);
  }

  static String dayMonthDate(DateTime dateTime) {
    return DateFormat('E, MMM dd').format(dateTime);
  }

  // 12:29 AM
  static String amPmTime(DateTime dateTime) {
    return DateFormat("hh:mm a").format(dateTime);
  }

  // 12:29 AM
  static String amPmFromString(String dateTime) {
    return DateFormat.jm().format(DateFormat("hh:mm: a").parse(dateTime));
  }

  // 01 Sep, 12:42 PM
  static String chatTimeStamp(DateTime dateTime) {
    return DateFormat('dd MMM, hh:mm a').format(dateTime);
  }

  // 01 Sep 2022, 12:42 PM
  static String completeDateTimeFormatter(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm:a').format(dateTime);
  }

  // 2021-10-10 12:29:00
  static String apiDateFormat(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }

  static String monthDayYear(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  static String dayMonthYearWithSash(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // 25-4-2022
  static String dayMonthYear(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static bool is10YearsOld(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 10 || yearDiff == 10 && monthDiff >= 0 && dayDiff >= 0;
  }

  // 2h ago
  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()}${(diff.inDays / 365).floor() == 1 ? "y" : "y"}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()}${(diff.inDays / 30).floor() == 1 ? "m" : "m"}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()}${(diff.inDays / 7).floor() == 1 ? "w" : "w"}";
    }
    if (diff.inDays > 0) return "${diff.inDays}${diff.inDays == 1 ? "d" : "d"}";
    if (diff.inHours > 0) {
      return "${diff.inHours}${diff.inHours == 1 ? "h" : "h"}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes}${diff.inMinutes == 1 ? "m" : "m"}";
      // return "${diff.inMinutes}${diff.inMinutes == 1 ? "minute" : "minutes"}";
    }
    if (diff.inSeconds > 10) {
      return "10s";
    }
    if (diff.inSeconds > 20) {
      return "20s";
    }
    if (diff.inSeconds > 30) {
      return "30s";
    }
    return "5s";
  }

  // TimeOfDay => 06:00 AM
  static String formatTimeOfDay(TimeOfDay? tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod!.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  static TimeOfDay timeOfDay(String stringTime) {
    TimeOfDay _timeOfDay = TimeOfDay(
        hour: int.parse(stringTime.split(":")[0]),
        minute: int.parse(stringTime.split(":")[1].split(" ")[0]));
    return _timeOfDay;
  }

  // TimeOfDay => 06:00:00
  static String convert12HrsFormatTo24Hrs(TimeOfDay? tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod!.hour, tod.minute);
    final format = DateFormat.Hms(); //"6:00 AM"
    return format.format(dt);
  }

  static TimeOfDay stringToTimeOfDay(String string) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(string));
  }

  static Future<String?> selectTime(BuildContext context) async {
    String? time;
    final TimeOfDay? timeOfDAy = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: Colors.lightBlue)
                  .copyWith(secondary: Colors.black),
            ),
            child: MediaQuery(
              data: MediaQuery.of(context!)
                  .copyWith(alwaysUse24HourFormat: false),
              child: child!,
            ),
          );
        }).catchError((error) {});
    if (timeOfDAy != null) {
      time = DateFormatter.formatTimeOfDay(timeOfDAy);
    } else {
      return null;
    }
    DateTime date = DateFormat.jm().parse(time);
    String otherTime =
        DateFormat("HH:mm: a").format(date).split('.').first.padLeft(8, "0");
    return otherTime;
  }

  static Future<String?> pickDateDialog(BuildContext context,
      [DateTime? dateTime]) async {
    String? date;
    DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: dateTime ?? DateTime.now(),
            firstDate: dateTime ?? DateTime(1950),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.black,
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  colorScheme:
                      const ColorScheme.light(primary: AppColors.acmeBlue)
                          .copyWith(secondary: Colors.black),
                ),
                child: child!,
              );
            },
            //what will be the previous supported year in picker
            lastDate: DateTime(3000))
        .catchError(
            (error) {}); //what will be the up to supported date in picker
    if (pickedDate != null) {
      date = DateFormatter.dayMonthYear(pickedDate);
    }
    return date;
  }
}
