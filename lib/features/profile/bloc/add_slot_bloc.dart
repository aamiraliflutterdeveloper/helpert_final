import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/profile/bloc/add_slot_state.dart';
import 'package:helpert_app/features/profile/repo/profile_repo.dart';

class AddSlotsBloc extends Cubit<AddSlotsState> {
  AddSlotsBloc() : super(InitialAddSlotsState());

  Future<void> addDaySlots(List<Map<String, dynamic>> data) async {
    try {
      Map<String, dynamic> rawData = {
        'saveUser_slot': data,
      };
      emit(AddSlotLoading());
      bool result = await ProfileRepo.instance.addDaySlotsApi(rawData);

      if (result) emit(AddSlotLoaded());
    } catch (e) {
      emit(AddSlotError(e.toString()));
    }
  }

  Future<void> addUnAvailableDays(List<Map<String, dynamic>> data) async {
    try {
      Map<String, dynamic> rawData = {
        'saveUser_offDays': data,
      };
      emit(AddSlotLoading());
      bool result = await ProfileRepo.instance.addUnavailableDaysApi(rawData);

      if (result) emit(AddSlotLoaded());
    } catch (e) {
      emit(AddSlotError(e.toString()));
    }
  }
}
