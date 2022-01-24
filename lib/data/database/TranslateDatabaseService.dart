import 'package:untitled/data/database/Translate.dart';

class TranslateDatabaseService {

  // todo async
  List<Translate> getDatabaseTranslate() {
    return _generateTranslateList();
  }

  List<Translate> _generateTranslateList() {

    Translate translate1 = Translate(
        'en',
        'ru',
        'test',
        'test'
    );

    Translate translate2 = Translate(
        'ru',
        'en',
        'test',
        'test'
    );

    List<Translate> testList = List.empty(growable: true);

    testList.add(translate1);
    testList.add(translate2);

    return testList;

  }

}