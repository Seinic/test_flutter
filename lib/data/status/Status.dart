import 'package:untitled/data/database/Translate.dart';
import 'package:untitled/data/translate/JniApi.dart';


abstract class Status<T> {

  T? data;
  Exception? exception;

  // Status<V> toMappedStatus<V>(V Function(T? inputData) mapper) {
  //   switch (runtimeType) {
  //     case Success:
  //       {
  //         if(data == null) {
  //           return Error(Exception("null data"));
  //         } else {
  //           return Success(mapper.call(data));
  //         }
  //       }
  //     default:
  //       {
  //         return Error(Exception("Anton error"));
  //       }
  //   }
  // }

}

class Success<T> extends Status<T> {

  Success(T? data);

}

class Error<T> extends Status<T> {

  Error(Exception? exception);

}

class Loading extends Status {

}
