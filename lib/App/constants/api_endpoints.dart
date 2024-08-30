class ApiEndpoints {

  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3001/api";
  // static const String baseUrl = "http://localhost:5500/api/";
  static const limit = 10;
  // Optionally, adjust the baseUrl to match your network setup or deployment environment


}
