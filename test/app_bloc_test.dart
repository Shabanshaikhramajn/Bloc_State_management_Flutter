// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:state_management/bloc/bloc_actions.dart';
// import 'package:state_management/bloc/person.dart';
// import 'package:state_management/bloc/persons_bloc.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_management/bloc/actions.dart';
import 'package:state_management/bloc/app_bloc.dart';
import 'package:state_management/bloc/app_state.dart';
import 'package:state_management/login_api.dart';
import 'package:state_management/models.dart';
import 'package:state_management/notes_api.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3')
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note?> notesToReturnForAcceptedLoginHandle;

  const DummyNotesApi({
    required this.acceptedLoginHandle,
    required this.notesToReturnForAcceptedLoginHandle
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.fooBar(),
        notesToReturnForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    if (loginHandle == acceptedLoginHandle) {
      return notesToReturnForAcceptedLoginHandle;
    } else {
      return null;
    }
  }



}

@immutable

class DummyLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReturn;
   ({required this.acceptedEmail, required this.acceptedPassword, required this.handleToReturn});
  DummyLoginApi.empty() :
  acceptedEmail = '',
 handleToReturn = LoginHandle.foobar(),
  acceptedPassword = '';
  @override
  Future<LoginHandle?> login({required String email, required String password})async{
  if (email == acceptedEmail && password = acceptedPassword){
  return const LoginTohandleReturn;

  }else {
  return null;
  }
  }

}



void main(){
  blocTest<AppBloc,AppState>("initial state of the bloc should be appstate.empty",
      build: ()=> AppBloc(
          loginApi:  DummyLoginApi.empty(),
          notesApi: DummyNotesApi.empty())
  );
  verify: (appState)=> expect(appState.state,
    const AppState.empty()
  );

  blocTest<AppBloc,AppState>("can we log in with incorrect credentials",
      build: ()=> AppBloc(
          loginApi:  DummyLoginApi(
            acceptedEmail: 'foosd',
            acceptedPassword: 'bar@baz.comsfsd'
          ),
          notesApi: DummyNotesApi.empty)
  );
  verify: (appState)=> expect(appState.state,
      const AppState.empty(),
    act: (appBloc)=> appBloc.add(
      const LoginAction(email: 'bar@baz.com', password: 'foo')
    )
      ,expect : ()=> [
        const AppState(
          isLoading:  true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
          
        ),
       const AppState(isLoading: false , fetchedNotes: null, loginHandle: LoginHandle(token: 'ABC  '), loginErrors: null),

      ]
  );


  blocTest<AppBloc,AppState>("can we log in with correct credentials",
      build: ()=> AppBloc(
          loginApi:  DummyLoginApi(
              acceptedEmail: 'foo',
              acceptedPassword: 'bar@baz.com'
          ),
          notesApi: DummyNotesApi.empty)
  );
  verify: (appState)=> expect(appState.state,
      const AppState.empty(),
      act: (appBloc)=> appBloc.add(
          const LoginAction(email: 'bar@baz.com', password: 'foo')
      )
      ,expect : ()=> [
        const AppState(
          isLoading:  true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,

        ),
        const AppState(isLoading: false , fetchedNotes: null, loginHandle: LoginHandle(token: 'ABC  '), loginErrors: null),

      ]
  );


  blocTest<AppBloc,AppState>("Load some notes with valid login handle",
      build: ()=> AppBloc(
          loginApi:  DummyLoginApi(
              acceptedEmail: 'foo',
              acceptedPassword: 'bar@baz.com'
          ),
          notesApi: DummyNotesApi(acceptedLoginHandle: LoginHandle(token: 'ABC')  , notesToReturnForAcceptedLoginHandle: mockNotes))
  );
  verify: (appState)=> expect(appState.state,
      const AppState.empty(),
      act: (appBloc)=> appBloc.add(
      const LoadNotesAction()
      )
      ,expect : ()=> [
        const AppState(
          isLoading:  true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,

        ),
        const AppState(isLoading: false , fetchedNotes: null, loginHandle: LoginHandle(token: 'ABC'), loginErrors: null),

      ]
  );
}
//5.07