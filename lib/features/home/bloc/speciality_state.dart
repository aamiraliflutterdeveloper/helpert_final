import 'package:helpert_app/features/home/models/specialists_model.dart';

abstract class SpecialityState {}

class InitialSpecialistState extends SpecialityState {}

class SpecialistLoadingState extends SpecialityState {}

class SpecialistLoadedState extends SpecialityState {
  final List<SpecialistsModel> doctorList;

  SpecialistLoadedState({required this.doctorList});
}

class SpecialistErrorState extends SpecialityState {
  final String error;

  SpecialistErrorState(this.error);
}

class SearchLoaded extends SpecialityState {
  final List<SpecialistsModel> foundUsers;
  SearchLoaded({required this.foundUsers});
}
