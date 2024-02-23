import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/exception_handler.dart';
import '../models/api_response.dart';

class SocialAuthService {
  SocialAuthService._constructor();

  static final instance = SocialAuthService._constructor();

  Future<ApiResponse> googleAuth() async {
    ApiResponse apiResponse = ApiResponse();

    final googleSignIn = GoogleSignIn();

    GoogleSignInAccount? _user;
    try {
      final googleUser = await googleSignIn.signIn();

      _user = googleUser;

      apiResponse.result = 'success';
      apiResponse.data = _user;
      apiResponse.message = 'Signup successfully!';
      googleSignIn.signOut();
      // _user.email;
      // _user.displayName;
      // _user.photoUrl;

      // final googleAuth = await googleUser.authentication;
    } catch (e) {
      apiResponse = ExceptionHandler.handleException(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> linkedinAuth() async {
    ApiResponse apiResponse = ApiResponse();

    return apiResponse;
  }
}
