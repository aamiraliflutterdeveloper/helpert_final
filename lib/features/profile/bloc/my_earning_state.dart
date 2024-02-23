import '../models/my_earning_model.dart';

abstract class MyEarningState {}

class InitialMyEarningState extends MyEarningState {}

class MyEarningLoadingState extends MyEarningState {}

class MyEarningLoadedState extends MyEarningState {
  final MyEarningModel myEarningModel;
  MyEarningLoadedState({required this.myEarningModel});
}

class MyEarningErrorState extends MyEarningState {
  final String error;

  MyEarningErrorState(this.error);
}
