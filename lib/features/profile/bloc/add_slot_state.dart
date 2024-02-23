abstract class AddSlotsState {}

class InitialAddSlotsState extends AddSlotsState {}

class AddSlotLoading extends AddSlotsState {}

class AddSlotLoaded extends AddSlotsState {}

class AddSlotError extends AddSlotsState {
  final String error;

  AddSlotError(this.error);
}
