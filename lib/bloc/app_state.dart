import 'package:flutter/foundation.dart' show immutable;
import 'package:state_management/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginErrors;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

   const AppState.empty(): isLoading = false, loginErrors = null, fetchedNotes= null, loginHandle = null;


  const AppState ({
   required this.isLoading,
   required this.fetchedNotes,
   required this.loginHandle,
   required this.loginErrors
  });

  // @override
  // String toString() => {
  //   'isLoading': isLoading,
  //   'loginError': loginErrors,
  //   'loginHandle': loginHandle,
  //   'fetchedNotes': fetchedNotes
  // } ;
}