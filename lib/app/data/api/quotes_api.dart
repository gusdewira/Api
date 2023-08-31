part of api;

class AuthApi extends Fetchly {
  Future<ResHandler> login(Map<String, dynamic> data) async =>
      await post('auth/login', data);
}
