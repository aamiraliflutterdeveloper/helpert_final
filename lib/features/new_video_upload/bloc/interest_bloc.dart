import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/models/user_model.dart';
import 'package:helpert_app/features/new_video_upload/bloc/interest_state.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';

class InterestBloc extends Cubit<InterestState> {
  InterestBloc() : super(InitialState());
  List<ListItem> interests = [];
  fetchAllInterest() async {
    try {
      interests = await VideoRepo.instance.allInterestApi();
    } catch (e) {
      emit(InterestError(e.toString()));
    }
  }
}
