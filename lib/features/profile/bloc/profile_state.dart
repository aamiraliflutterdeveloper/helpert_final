import 'package:helpert_app/features/profile/models/slot_days_model.dart';
import 'package:helpert_app/features/profile/models/unAvailAbleDateModel.dart';

abstract class ProfileState {}

class InitialState extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final DaysListModel? daysListModel;
  final UnavailableDateListModel? unavailableDateListModel;

  ProfileLoaded({this.daysListModel, this.unavailableDateListModel});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
