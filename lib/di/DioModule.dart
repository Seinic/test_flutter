import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {

  @lazySingleton
  Dio dio() {
    Dio dio = Dio();

    //todo timeout settings

    // customization
    dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
        )
    );
    return dio;
  }

}