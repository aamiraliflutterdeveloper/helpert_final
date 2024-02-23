import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/calendar_data_state.dart';
import 'package:helpert_app/features/book_call/model/calendar_data_model.dart';
import 'package:helpert_app/features/book_call/repo/book_call_repo.dart';

class CalendarDataBloc extends Cubit<CalendarDataState> {
  CalendarDataBloc() : super(InitialCalendarDataState());

  Future<void> fetchCalendarData(
    int doctorId,
  ) async {
    emit(CalendarDataLoading());
    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
      });
      CalendarDataModel result =
          await BookCallRepo.instance.fetchCalendarData(data);

      emit(CalendarDataLoaded(calendarDataModel: result));
    } catch (e) {
      emit(CalendarDataError(e.toString()));
    }
  }

  Future<void> fetchAvailableDays(int doctorId, String date) async {
    emit(CalendarDataLoading());
    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
        'date': date,
      });
      List<CalendarDaysModel> result =
          await BookCallRepo.instance.fetchAvailableDays(data);

      emit(CalendarDaysLoaded(calendarDaysList: result));
    } catch (e) {
      emit(CalendarDataError(e.toString()));
    }
  }
}
