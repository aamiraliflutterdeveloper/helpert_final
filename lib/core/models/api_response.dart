class ApiResponse<T> {
  String? result;
  String? message;
  T? data;
  String? token;

  ApiResponse();

  ApiResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = json['data'];
    token = json['token'];
  }
}
