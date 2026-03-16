import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  const Urls();
  static final baseUrl = dotenv.env['BASE_URL'];
}

