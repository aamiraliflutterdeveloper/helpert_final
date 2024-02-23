import 'package:helpert_app/features/book_call/model/booking_model.dart';

abstract class SaveSlotState {}

class InitialSaveSlotsState extends SaveSlotState {}

class SaveSlotLoading extends SaveSlotState {}

class SaveSlotLoaded extends SaveSlotState {
  final BookingModel bookingModel;

  SaveSlotLoaded({required this.bookingModel});
}

class SaveSlotError extends SaveSlotState {
  final String error;

  SaveSlotError(this.error);
}
