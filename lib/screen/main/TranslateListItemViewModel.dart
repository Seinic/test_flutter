import 'package:untitled/data/database/Translate.dart';

class TranslateListItemViewModel {

  TranslateListItemViewModel(this.translate);

  Translate translate;

  void vocalizeInput() {
    _vocalizeText(translate.inputText);
  }

  void vocalizeOutput() {
    _vocalizeText(translate.outputText);
  }

  void _vocalizeText(String text) {
    print('vocalizeText: $text');
  }

}