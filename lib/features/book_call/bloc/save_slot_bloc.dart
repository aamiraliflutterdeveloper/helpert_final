import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/core/services/socket_service.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/book_call/bloc/save_slot_state.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';
import 'package:helpert_app/features/book_call/repo/book_call_repo.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SaveSlotBloc extends Cubit<SaveSlotState> {
  SaveSlotBloc() : super(InitialSaveSlotsState());

  Future<void> saveBookingSlot(
    String appointmentDescription,
    int doctorId,
    String date,
    int slotId,
    int cardNumber,
    int expMonth,
    int expYear,
    int cvc,
    String paymentType,
    int dayId,
  ) async {
    emit(SaveSlotLoading());

    try {
      var data = FormData.fromMap({
        'doctor_id': doctorId,
        'date': date,
        'slot_id': slotId,
        'card_number': cardNumber,
        'exp_month': expMonth,
        'exp_year': expYear,
        'cvc': cvc,
        'payment_type': paymentType,
        'day_id': dayId,
        'description': appointmentDescription,
      });
      BookingModel result =
          await BookCallRepo.instance.saveBookingSlotApi(data);
      debugPrint('PAYMENT RESULT IS :: $result');
      emitNotification(doctorId);

      emit(SaveSlotLoaded(bookingModel: result));
    } catch (e) {
      debugPrint('PAYMENT EXCEPTION IS :: $e');
      if (e.toString().contains('Your card number is incorrect')) {
        emit(SaveSlotError('Your card number is incorrect'));
      } else {
        emit(SaveSlotError(e.toString()));
      }
    }
  }

  void emitNotification(int doctorId) {
    Socket socket = SocketService.instance.socket;

    try {
      socket.emit(SocketEmit.GET_NOTIFICATIONS, {
        'user_id': AuthRepo.instance.user.userId,
        'doctor_id': doctorId,
      });
    } catch (e) {
      debugPrint('emit notification exception is :: $e');
    }
  }
}
