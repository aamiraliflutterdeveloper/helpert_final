import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/available_slots_state.dart';
import 'package:helpert_app/features/book_call/repo/book_call_repo.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

class AvailableSlotsBloc extends Cubit<AvailableSlotsState> {
  AvailableSlotsBloc() : super(InitialAvailableSlotsState());

  Future<void> availableSlots(int doctorId, DateTime date) async {
    emit(AvailableSlotLoading());
    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
        'date': date,
      });
      DaysModel result = await BookCallRepo.instance.availableSlotsApi(data);
      emit(AvailableSlotLoaded(dayModel: result));
    } catch (e) {
      emit(AvailableSlotError(e.toString()));
    }
  }
}
