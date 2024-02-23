import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:helpert_app/features/appointment/model/appointment_model.dart';
import 'package:helpert_app/features/book_call/model/booking_model.dart';
import 'package:helpert_app/features/chat/cubit/video_call_state.dart';
import 'package:helpert_app/features/video_call/repo/home_repo.dart';
import 'package:intl/intl.dart';

import '../../auth/repo/auth_repo.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  VideoCallCubit() : super(VideoCallInitial());

  Future<bool> callingUserStatus(int receiverId) async {
    try {
      var data = FormData.fromMap({
        'receiverId': receiverId,
      });
      bool result = await HomeRepo.instance.callingUserStatus(data);
      return result;
    } catch (e) {
      emit(VideoCallLoaded(null, true, e.toString(), 0, 0, 0));
      return false;
    }
  }

  Future<String> getAgoraToken(String channelName) async {
    try {
      var data = FormData.fromMap({
        'channelName': channelName,
      });
      String result = await HomeRepo.instance.getAgoraToken(data);
      return result;
    } catch (e) {
      emit(VideoCallLoaded(null, true, e.toString(), 0, 0, 0));
      return '';
    }
  }

  void getUserAppointment(int otherId) async {
    print(otherId);
    print(AuthRepo.instance.user.userId);
    emit(VideoCallLoading());
    DateTime dateTime = DateTime.now();
    String time = DateFormat("hh:mm").format(dateTime);
    String minutes = getMinutes(dateTime.minute);
    final dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute);
    final format = DateFormat.jm();
    String dateString = format.format(dt);
    print('${dateTime.year}-${dateTime.month}-${dateTime.day}');

    try {
      var data = FormData.fromMap({
        'user_id': AuthRepo.instance.user.userId,
        'date': '${dateTime.year}-${dateTime.month}-${dateTime.day}',
        'slot_time':
            "${time.substring(0, 2)}:$minutes ${dateString.substring(dateString.length - 2)}",
      });
      var getAppointmentData = FormData.fromMap({
        'ids': "${AuthRepo.instance.user.userId},${otherId}",
        'date': '${dateTime.year}-${dateTime.month}-${dateTime.day}',
      });
      var futureResults = await Future.wait([
        HomeRepo.instance.getUserBooking(data),
        HomeRepo.instance.getAppointment(getAppointmentData),
      ]);
      List<BookingModel> result = futureResults[0] as List<BookingModel>;
      if (result.isNotEmpty) {
        var results = await Future.wait([
          getVideoCallAvailability(result, otherId),
          getVideoCallDoctorId(result, otherId),
          getVideoCallUserId(result, otherId),
          getVideoCallBookingId(result, otherId),
        ]);
        print('Video call loaded');
        emit(VideoCallLoaded(
            futureResults[1] as AppointmentModel,
            results[0] as bool,
            '',
            results[1] as int,
            results[2] as int,
            results[3] as int));
      } else {
        emit(VideoCallLoaded(
            futureResults[1] as AppointmentModel, false, '', 0, 0, 0));
      }
    } catch (e) {
      if (e.toString().contains('No Booking Found')) {
        emit(VideoCallLoaded(null, false, e.toString(), 0, 0, 0));
      } else {
        emit(VideoCallLoaded(null, false, e.toString(), 0, 0, 0));
      }
    }
  }

  String getMinutes(int minutes) {
    if (minutes < 30 && minutes >= 0) {
      return '00';
    } else {
      return '30';
    }
  }

  Future<bool> getVideoCallAvailability(
      List<BookingModel> bookings, int otherId) async {
    List<BookingModel> myBookings = bookings
        .where((element) =>
            (element.doctorId == AuthRepo.instance.user.userId &&
                element.bookingUserId == otherId) ||
            (element.doctorId == otherId &&
                element.bookingUserId == AuthRepo.instance.user.userId))
        .toList();
    if (myBookings.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getVideoCallDoctorId(
      List<BookingModel> bookings, int otherId) async {
    List<BookingModel> myBookings = bookings
        .where((element) =>
            (element.doctorId == AuthRepo.instance.user.userId &&
                element.bookingUserId == otherId) ||
            (element.doctorId == otherId &&
                element.bookingUserId == AuthRepo.instance.user.userId))
        .toList();
    if (myBookings.isNotEmpty) {
      return myBookings[0].doctorId;
    } else {
      return 0;
    }
  }

  Future<int> getVideoCallUserId(
      List<BookingModel> bookings, int otherId) async {
    List<BookingModel> myBookings = bookings
        .where((element) =>
            (element.doctorId == AuthRepo.instance.user.userId &&
                element.bookingUserId == otherId) ||
            (element.doctorId == otherId &&
                element.bookingUserId == AuthRepo.instance.user.userId))
        .toList();
    if (myBookings.isNotEmpty) {
      return myBookings[0].bookingUserId;
    } else {
      return 0;
    }
  }

  Future<int> getVideoCallBookingId(
      List<BookingModel> bookings, int otherId) async {
    List<BookingModel> myBookings = bookings
        .where((element) =>
            (element.doctorId == AuthRepo.instance.user.userId &&
                element.bookingUserId == otherId) ||
            (element.doctorId == otherId &&
                element.bookingUserId == AuthRepo.instance.user.userId))
        .toList();
    if (myBookings.isNotEmpty) {
      return myBookings[0].id;
    } else {
      return 0;
    }
  }
}
