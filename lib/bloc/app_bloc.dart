import 'package:bloc/bloc.dart';
import 'package:state_management/bloc/actions.dart';
import 'package:state_management/bloc/app_state.dart';
import 'package:state_management/login_api.dart';
import 'package:state_management/notes_api.dart';

class AppBloc extends Bloc<AppAction,AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
}