import 'package:helpert_app/features/book_call/model/calendar_data_model.dart';

abstract class CalendarDataState {}

class InitialCalendarDataState extends CalendarDataState {}

class CalendarDataLoading extends CalendarDataState {}

class CalendarDataLoaded extends CalendarDataState {
  final CalendarDataModel calendarDataModel;

  CalendarDataLoaded({required this.calendarDataModel});
}

class CalendarDaysLoaded extends CalendarDataState {
  final List<CalendarDaysModel> calendarDaysList;

  CalendarDaysLoaded({required this.calendarDaysList});
}

class CalendarDataError extends CalendarDataState {
  final String error;

  CalendarDataError(this.error);
}
