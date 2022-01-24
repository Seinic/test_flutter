import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled/data/TextToSpeechService.dart';
import 'package:untitled/data/database/Translate.dart';
import 'package:untitled/data/database/TranslateDatabaseService.dart';
import 'package:untitled/data/translate/TranslateRepository.dart';
import 'package:untitled/screen/main/MainScreenBottomBarViewModel.dart';
import 'package:untitled/screen/main/TranslateListItemViewModel.dart';

class MainScreenViewModel with ChangeNotifier {

  MainScreenViewModel(
      this.translateDatabaseService,
      this.textToSpeechService,
      this.translateRepository
  ) : translateList = translateDatabaseService.getDatabaseTranslate().map((e) => TranslateListItemViewModel(e)).toList() {
    textToSpeechService.initSpeechToText();
}

  TranslateDatabaseService translateDatabaseService;
  TextToSpeechService textToSpeechService;
  TranslateRepository translateRepository;

  MainScreenBottomBarViewModel bottomBarViewModel = MainScreenBottomBarViewModel();

  List<TranslateListItemViewModel> translateList;

  void onInputVoiceToTextPressed() {
    startSpeechToText('en_GB');
  }

  void onOutputVoiceToTextPressed() {
    startSpeechToText('ru_RU');
  }

  void startSpeechToText(String languageId) {
    // вызов напрямую из онПресед () => viewModel.startSpeechToText('ru_RU')
    textToSpeechService.startSpeechToText(executeTranslate, languageId);
  }

  void executeTranslate(String textToTranslate) {
    translateRepository.testTranslate(textToTranslate).then((value) => feedResult(value));
  }

  void feedResult(Translate translate) {
    translateList.add(
      TranslateListItemViewModel(
        translate
      )
    );
    notifyListeners();
  }

  // void addTranslateToList() {
  //   translateList.add(
  //     TranslateListItemViewModel(
  //       Translate(
  //         'asd',
  //         'ads',
  //         'tdfasdsdfdf',
  //         'sdsfdfdsfdsfs'
  //       )
  //     )
  //   );
  //   notifyListeners();
  //   print('translate size: ${translateList.length}');
  // }


}
