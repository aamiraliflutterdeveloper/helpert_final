import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/home/bloc/speciality_state.dart';
import 'package:helpert_app/features/home/models/specialists_model.dart';

import '../repo/speciality_repo.dart';

class SpecialityBloc extends Cubit<SpecialityState> {
  SpecialityBloc() : super(InitialSpecialistState());

  Future<void> fetchSpeciality() async {
    try {
      emit(SpecialistLoadingState());

      List<SpecialistsModel> speciality =
          await SpecialistRepo.instance.fetchSpecialityApi();
      speciality.removeWhere(
          (element) => AuthRepo.instance.user.userId == element.doctorId);
      if (speciality.isNotEmpty) {
        emit(SpecialistLoadedState(doctorList: speciality));
      }
    } catch (e) {
      emit(SpecialistErrorState(e.toString()));
    }
  }

  Future<void> search(enteredKeyword, allUsers) async {
    List<SpecialistsModel> foundUsers = [];
    foundUsers = searchUser(enteredKeyword, allUsers);
    emit(SearchLoaded(foundUsers: foundUsers));
  }
}

List<SpecialistsModel> searchUser(String enteredKeyword, allUsers) {
  List<SpecialistsModel> results = [];
  results = allUsers
      .where((user) =>
          user.username.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
          user.specialization
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
      .toList();
  return results;
}
