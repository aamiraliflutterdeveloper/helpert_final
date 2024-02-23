import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/prefs.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/notifications/cloud_messaging_service.dart';
import '../../../core/services/rest_api_service.dart';
import '../../../core/services/social_auth_service.dart';
import '../../../utils/shared_preference_manager.dart';
import '../models/social_user_model.dart';
import '../models/user_model.dart';

class SocialAuthRepository {
  SocialAuthRepository._constructor();

  static final SocialAuthRepository instance =
      SocialAuthRepository._constructor();

  Future<SocialUserModel> socialAuth(String provider, int type) async {
    String? token = await CloudMessagingService.instance.getToken();

    String v4 = Uuid().v4();
    ApiResponse apiResponse = ApiResponse();
    if (provider == 'GOOGLE') {
      apiResponse = await SocialAuthService.instance.googleAuth();
    } else if (provider == 'APPLE') {
      apiResponse = await SocialAuthService.instance.linkedinAuth();
    }
    if (apiResponse.result == 'success') {
      if (provider == 'GOOGLE') {
        GoogleSignInAccount userData = apiResponse.data;
        SocialUserModel googleUserModel = SocialUserModel(
            uuid: userData.id,
            type: type,
            firstName: '',
            lastName: '',
            fullName: userData.displayName!,
            imageUrl: userData.photoUrl!,
            provider: 'GMAIL',
            email: userData.email,
            fcmToken: token);
        return googleUserModel;
      } else {
        GoogleSignInAccount userData = apiResponse.data;
        SocialUserModel googleUserModel = SocialUserModel(
            type: type,
            uuid: v4,
            firstName: '',
            lastName: '',
            fullName: userData.displayName!,
            imageUrl: userData.photoUrl!,
            provider: 'APPLE',
            email: userData.email,
            fcmToken: token);
        return googleUserModel;
      }
    } else {
      throw apiResponse.message!;
    }
  }

  Future<bool> socialAuthApi(FormData formData) async {
    ApiResponse apiResponse = await RestApiService.instance.postUri(
      kSocialLoginApi,
      formData: formData,
      isTokenRequired: false,
    );
    // response management
    if (apiResponse.result == 'success') {
      // Storing user in local db
      UserModel userModel = UserModel.fromJson(apiResponse.data);
      AuthRepo.instance.user = userModel;
      AuthRepo.instance.saveAndUpdateSession(userModel);
      // Saving token for session management
      if (apiResponse.token != null) {
        PreferenceManager.instance.setString(Prefs.TOKEN, apiResponse.token!);
        PreferenceManager.instance
            .setString(Prefs.USER_ROLE, userModel.userRole.toString());
      }
      return true;
    } else {
      throw apiResponse.message!;
    }
  }
}
