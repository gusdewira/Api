library api;

import 'package:fetchly/fetchly.dart';

part 'auth_api.dart';
part 'quotes_api.dart';

mixin UseApi {
  QuoteApi quoteApi = QuoteApi();
  AuthApi authApi = AuthApi();
}
