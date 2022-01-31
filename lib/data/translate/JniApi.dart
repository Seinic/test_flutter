import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/data/status/Status.dart';

part 'JniApi.g.dart';

const String CLIENT_TAG = "client";
const String USER_AGENT_TAG = "user-agent";
const String CHROME_USER_AGENT =
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) " +
        "AppleWebKit/537.36 (KHTML, like Gecko) " +
        "Chrome/89.0.4389.90 Safari/537.36";
const String CHROME_CLIENT_QUERY_PARAM = "dict-chrome-ex";
const String JNI_BASE_URL = "https://clients5.google.com/translate_a";

@RestApi(baseUrl: JNI_BASE_URL) //todo cpp hide
abstract class JniApi {

  factory JniApi(Dio dio, {String baseUrl}) = _JniApi;

  @GET("/t?")
  Future<JniTranslateNetworkResponse> executeTranslate(
      @Queries() Map<String, dynamic> queriesParams
  );

}

@JsonSerializable()
class JniTranslateNetworkResponse {

  List<JniTranslateSentence> sentences = List.empty();

  JniTranslateNetworkResponse(this.sentences);


  factory JniTranslateNetworkResponse.fromJson(Map<String, dynamic> json) => _$JniTranslateNetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JniTranslateNetworkResponseToJson(this);
}

@JsonSerializable()
class JniTranslateSentence {

  String? trans;

  JniTranslateSentence({this.trans});


  factory JniTranslateSentence.fromJson(Map<String, dynamic> json) => _$JniTranslateSentenceFromJson(json);
  Map<String, dynamic> toJson() => _$JniTranslateSentenceToJson(this);

}

@module
abstract class JniTranslateModule {

  @lazySingleton
  JniApi jniApi(Dio dio) {
    Map<String, String> headers = {
      USER_AGENT_TAG : CHROME_USER_AGENT
    };
    dio.options.headers = headers;
    return JniApi(dio);
  }

}



