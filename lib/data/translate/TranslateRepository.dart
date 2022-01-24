import 'package:untitled/data/database/Translate.dart';

class TranslateRepository {

  Future<Translate> testTranslate(String input) async {
    await Future.delayed(
        const Duration(seconds: 1)
    );
    return Translate('input lang', 'output lang', input, "типа перевел... " + input);
  }

}