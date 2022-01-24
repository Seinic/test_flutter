import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextToSpeechService {

  final SpeechToText _speechToText = SpeechToText();
  Function? testFunctionCallback;

  void initSpeechToText() async {
    await _speechToText.initialize();
    // todo setState(() {});
    print('has tts pemission: ${_speechToText.hasPermission}');
    // var locales = await _speechToText.locales();
    // locales.forEach((element) { print('id: ${element.localeId}'); });
  }

  void startSpeechToText(Function testCallback, String lang) async {
    testFunctionCallback = testCallback;
    await _speechToText.listen(
      localeId: lang,
      onResult: _onSpeechResult
    );
    // todo setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print('result: ${result}');
    print('tts result: ${result.recognizedWords}');
    if (result.finalResult) {
      print('final result: ${result.recognizedWords}');
      testFunctionCallback?.call(result.recognizedWords); //todo бля серьезно?
      testFunctionCallback = null;
    }
    // setState(() {
    //   print('tts result: ${result.recognizedWords}');
    //   _recognizedText = result.recognizedWords;
    // });
  }

  String _testSetResult(String result) {
    return result;
  }

}