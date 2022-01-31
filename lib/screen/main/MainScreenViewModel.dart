import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/data/TextToSpeechService.dart';
import 'package:untitled/data/database/Translate.dart';
import 'package:untitled/data/database/TranslateDatabaseService.dart';
import 'package:untitled/data/status/Status.dart';
import 'package:untitled/data/translate/TranslateRepository.dart';
import 'package:untitled/screen/main/MainScreenBottomBarViewModel.dart';
import 'package:untitled/screen/main/TranslateListItemViewModel.dart';

@injectable
class MainScreenViewModel with ChangeNotifier {

  MainScreenViewModel(
      this.translateDatabaseService,
      this.textToSpeechService,
      this.translateRepository
  ) : translateList = translateDatabaseService.getDatabaseTranslate().map((e) => TranslateListItemViewModel(e)).toList() {
    // textToSpeechService.initSpeechToText();
}

  TranslateDatabaseService translateDatabaseService;
  TextToSpeechService textToSpeechService;
  TranslateRepository translateRepository;
  bool isLoading = false;

  MainScreenBottomBarViewModel bottomBarViewModel = MainScreenBottomBarViewModel();

  List<TranslateListItemViewModel> translateList;

  onInputVoiceToTextPressed() {
    textToSpeechService.initSpeechToText();
    startSpeechToText('en_GB');
  }

  void onOutputVoiceToTextPressed() {
    startSpeechToText('ru_RU');
  }

  void startSpeechToText(String languageId) {
    // вызов напрямую из онПресед () => viewModel.startSpeechToText('ru_RU')
    isLoading = true;
    notifyListeners();
    textToSpeechService.startSpeechToText(executeTranslate, languageId);
  }

  void executeTranslate(String textToTranslate) {
    translateRepository.testTranslate("ru", "en", textToTranslate).then((value) => feedResult(_handleTranslateResult(value)));
  }

  _handleTranslateResult(Status<Translate> result) {
    switch (result.runtimeType) {
      case Success: {
        if(result.data != null) {
          feedResult(result.data!);
        } else {
          // todo handle null result
          print("handle null result");
        }
        break;
      }

      case Error: {
        print("handle loading");

      }


    }
  }

  void feedResult(Translate translate) {
    isLoading = false;
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
