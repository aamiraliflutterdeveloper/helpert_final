import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/my_earning_model.dart';
import '../repo/profile_repo.dart';
import 'my_earning_state.dart';

class MyEarningBloc extends Cubit<MyEarningState> {
  MyEarningBloc() : super(InitialMyEarningState());
  Future<void> fetchEarning() async {
    try {
      emit(MyEarningLoadingState());
      MyEarningModel result = await ProfileRepo.instance.myEarningApi();
      print(result.object);
      if (result.available.isNotEmpty) {
        emit(MyEarningLoadedState(myEarningModel: result));
      }
    } catch (e) {
      emit(MyEarningErrorState(e.toString()));
    }
  }
}
