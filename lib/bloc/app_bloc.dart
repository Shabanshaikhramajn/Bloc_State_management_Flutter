import 'package:bloc/bloc.dart';
import 'package:state_management/bloc/actions.dart';
import 'package:state_management/bloc/app_state.dart';
import 'package:state_management/login_api.dart';
import 'package:state_management/models.dart';
import 'package:state_management/notes_api.dart';

class AppBloc extends Bloc<AppAction,AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi
}): super(const AppState.empty()){
    on<LoginAction>((event, emit)async{
      emit(AppState(isLoading: true, fetchedNotes: null, loginHandle: null, loginErrors: null));
      //log the user in
      final loginHandle = await loginApi.login(email: event.email, password: event.password);
      emit(
        AppState(isLoading: false , fetchedNotes: null, loginHandle: loginHandle, loginErrors: loginHandle ==null ? LoginErrors.invalidHandle : null)
      );
     

    });
    on<LoadNotesAction>((event, emit)async{
      emit(AppState(isLoading: true, fetchedNotes: null, loginHandle: state.loginHandle, loginErrors: null));
      final loginHandle = state.loginHandle;
      if(loginHandle != const LoginHandle.fooBar()){
        emit(AppState(isLoading: false, fetchedNotes: null, loginHandle: loginHandle, loginErrors: LoginErrors.invalidHandle));
        return;
      }
      //we have valid login handle
      final notes = await notesApi.getNotes(loginHandle: loginHandle!);
      emit(AppState(isLoading: false, fetchedNotes: notes, loginHandle: loginHandle, loginErrors: null));

    });
  
    
  }
}