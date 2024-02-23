import 'package:helpert_app/features/book_call/model/booking_model.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

abstract class AvailableSlotsState {}

class InitialAvailableSlotsState extends AvailableSlotsState {}

class AvailableSlotLoading extends AvailableSlotsState {}

class AddSlotLoading extends AvailableSlotsState {}

class AvailableSlotLoaded extends AvailableSlotsState {
  final DaysModel dayModel;

  AvailableSlotLoaded({required this.dayModel});
}

class AddSlotLoaded extends AvailableSlotsState {
  final BookingModel bookingModel;

  AddSlotLoaded({required this.bookingModel});
}

class AvailableSlotError extends AvailableSlotsState {
  final String error;

  AvailableSlotError(this.error);
}
