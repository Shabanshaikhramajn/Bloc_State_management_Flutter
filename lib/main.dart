import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/bloc/actions.dart';
import 'package:state_management/bloc/app_bloc.dart';
import 'package:state_management/bloc/app_state.dart';
import 'package:state_management/dialogs/generic_dialog.dart';
import 'package:state_management/dialogs/loading_screen.dart';
import 'package:state_management/login_api.dart';
import 'package:state_management/models.dart';
import 'package:state_management/notes_api.dart';
import 'package:state_management/strings.dart';
import 'package:state_management/views/iterable_list_view.dart';
import 'package:state_management/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    late final Bloc myBloc;
    return BlocProvider(
      create: (context) => AppBloc(
          loginApi: LoginApi(),
          notesApi: NotesApi()
      ),
      child: Scaffold(
        body: BlocConsumer<AppBloc, AppState>(
            builder: (context,state){
             final notes = state.fetchedNotes;
             if(notes == null){
               return LoginView(
                   onLoginTapped:(email, password){
                   context.read<AppBloc>().add(LoginAction(email: email, password: password));
                   }
               );
             }else {
               return notes.toListView();
             }
            },
            listener: (context,state){
              //loading screen
              if(state.isLoading){
                 LoadingScreen.instance().show(
                     context: context,
                     text: pleaseWait
                 );
              } else {
                LoadingScreen.instance().hide();
              }
              //display possible errors
              final loginError = state.loginErrors;
              if(loginError !=null){
                showGenericDialog(context: context, title: "Login Error", content: loginErrorDialogContent , optionsBuilder: ()=> {ok: true});
              }
              //if we have loggged in, but we have no fetched notes,fetch them now
              if(state.isLoading == false && state.loginErrors == null && state.loginHandle == const LoginHandle.fooBar() && state.fetchedNotes == null){
                context.read<AppBloc>().add(
                  const LoadNotesAction()
                );
              }
            })
      ),
    );
  }
}

//4.21
