import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/data/database/Translate.dart';
import 'package:untitled/data/status/Status.dart';
import 'package:untitled/data/translate/JniApi.dart';

@injectable
class RandomTranslateService {
  JniApi jniApi;

  RandomTranslateService(this.jniApi);

  Future<Status<Translate>> executeTranslate(
      String inputLang, String outputLang, String text) async {
    Map<String, String> params = {
      CLIENT_TAG: CHROME_CLIENT_QUERY_PARAM,
      "s1": inputLang,
      "t1": outputLang,
      "q": text
    };

    var result = await jniApi.executeTranslate(params)
        .then((value) {
          print('translate response: $value');
          return Success(value.mapToTranslate());
        }
      ).catchError((Object error) {
        print('error cath: $error');
        if (error is DioError) {
          return Error(Exception("Error code: ${(error as DioError).response?.statusCode} message: ${(error as DioError).response?.statusMessage}"));
        } else {
          return Error(Exception("Anton error"));
        }
    });

    print('final handler result data: ${result.data} , error: ${result.exception}');

    return Future.value(result);
  }

  Translate qwe(JniTranslateNetworkResponse? jniTranslateNetworkResponse) {
    return jniTranslateNetworkResponse!.mapToTranslate(); //todo nullability
  }

  // Status<Translate> _handleTranslateResponse(
  //   Status<JniTranslateNetworkResponse> response
  // ) {
  //   switch (response.runtimeType) {
  //     case Success:
  //       {
  //         return Success(response.data?.mapToTranslate());
  //       }
  //
  //     case Error:
  //       {
  //         return Error(response.exception);
  //       }
  //
  //     default:
  //       {
  //         return Error(Exception("unknown"));
  //       }
  //   }
  // }
}

extension ToTranslate on JniTranslateNetworkResponse {
  Translate mapToTranslate() {
    return Translate(
        "inputLanguage",
        "outputLanguage",
        "inputText",
        sentences.first.trans!
    ); //todo join to String
  }
}
