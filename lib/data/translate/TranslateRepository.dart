import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/data/database/Translate.dart';
import 'package:untitled/data/status/Status.dart';
import 'package:untitled/data/translate/RandomTranslateService.dart';

@injectable
class TranslateRepository {

  TranslateRepository(this.randomTranslateService);

  RandomTranslateService randomTranslateService;

  Future<Status<Translate>> testTranslate(String inputLang, String outputLang, String input) async {
    //todo emit Loading then emit result
    return randomTranslateService.executeTranslate(inputLang, outputLang, input);
  }

}