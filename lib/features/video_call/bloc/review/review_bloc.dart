import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/video_call/bloc/review/review_state.dart';
import 'package:helpert_app/features/video_call/repo/home_repo.dart';

class ReviewBloc extends Cubit<ReviewState> {
  ReviewBloc() : super(ReviewInitial());
  static ReviewBloc get(context) => BlocProvider.of(context);

  void bookingRating(int userId, double rating, int bookingId) async {
    try {
      emit(ReviewLoadingState());
      var data = FormData.fromMap({
        'user_id': userId,
        'rating': rating,
        'booking_id': bookingId,
      });

      bool result = await HomeRepo.instance.bookingRating(data);
      if (result) {
        emit(ReviewLoadedState());
      }
    } catch (e) {
      emit(ReviewErrorState(e.toString()));
    }
  }
}
