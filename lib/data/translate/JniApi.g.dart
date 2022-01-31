// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JniApi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JniTranslateNetworkResponse _$JniTranslateNetworkResponseFromJson(
        Map<String, dynamic> json) =>
    JniTranslateNetworkResponse(
      (json['sentences'] as List<dynamic>)
          .map((e) => JniTranslateSentence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JniTranslateNetworkResponseToJson(
        JniTranslateNetworkResponse instance) =>
    <String, dynamic>{
      'sentences': instance.sentences,
    };

JniTranslateSentence _$JniTranslateSentenceFromJson(
        Map<String, dynamic> json) =>
    JniTranslateSentence(
      trans: json['trans'] as String?,
    );

Map<String, dynamic> _$JniTranslateSentenceToJson(
        JniTranslateSentence instance) =>
    <String, dynamic>{
      'trans': instance.trans,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _JniApi implements JniApi {
  _JniApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://clients5.google.com/translate_a';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<JniTranslateNetworkResponse> executeTranslate(queriesParams) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queriesParams);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<JniTranslateNetworkResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/t?',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = JniTranslateNetworkResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
