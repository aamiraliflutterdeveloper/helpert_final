import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/repo/auth_repo.dart';
import 'edit_profile_specialization_state.dart';

class EditProfileSpecializationBloc
    extends Cubit<EditProfileSpecializationState> {
  EditProfileSpecializationBloc() : super(InitialState());

  Future<void> editSpecialization(Map<String, dynamic> userDate) async {
    emit(UpdateSpecializationLoading());
    var data = FormData.fromMap(userDate);
    bool result = await AuthRepo.instance.editSpecializationApi(data);
    if (result) emit(UpdateSpecializationLoaded());
    try {} catch (e) {
      emit(UpdateSpecializationError(e.toString()));
    }
  }
}
