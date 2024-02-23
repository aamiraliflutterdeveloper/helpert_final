import '../../../constants/api_endpoints.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/rest_api_service.dart';
import '../models/specialists_model.dart';

class SpecialistRepo {
  SpecialistRepo.privateConstructor();

  static final SpecialistRepo instance = SpecialistRepo.privateConstructor();

  Future<List<SpecialistsModel>> fetchSpecialityApi() async {
    ApiResponse apiResponse = await RestApiService.instance.getUri(
      kFetchSpecialityApi,
      isTokenRequired: true,
    );

    if (apiResponse.result == 'success') {
      List<SpecialistsModel> specialityList = List<SpecialistsModel>.from(
          apiResponse.data.map((x) => SpecialistsModel.fromJson(x)));
      // for (var a = 0; a < apiResponse.data.length; a++) {
      //   specialityList.add(apiResponse.data[a]);
      // }
      return specialityList;
    } else {
      throw apiResponse.message!;
    }
  }
}
