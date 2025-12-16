import 'package:flutter/foundation.dart' show immutable;
import 'package:state_management/models.dart';
import 'package:collection/collection.dart';

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

  @override
  bool operator ==(covariant AppState other){
     final otherPropertiesAreEqual =  isLoading == other.isLoading &&
         loginErrors == other.loginErrors &&
         loginHandle == other.loginHandle;

     if(fetchedNotes ==null && other.fetchedNotes ==null){
       return otherPropertiesAreEqual;
     }else {
       return otherPropertiesAreEqual &&
           (fetchedNotes?.isEqualTo(other.fetchedNotes) ?? false);

     }
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(
    isLoading,
    loginErrors,
    loginHandle,
    fetchedNotes
  );



  // @override
  // String toString() => {
  //   'isLoading': isLoading,
  //   'loginError': loginErrors,
  //   'loginHandle': loginHandle,
  //   'fetchedNotes': fetchedNotes
  // } ;
}

extension UnorderedEquality on Object {
  bool isEqualTo(other)=>
      const DeepCollectionEquality.unordered().equals(this, other);
}