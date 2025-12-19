import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math'as math;
typedef AppBLocRandomUrlPicker = String Function(Iterable<String>allUrls);


extension RandomElement<T> on Iterable<T>{
  T getRandomElement()=> elementAt(math.Random().nextInt(length));
}

typedef AppBlocUrlLoader = Future<Uint8List>Function(String url);


class AppBloc extends Bloc<AppEvent,AppState>{

  String _pickRandomUrl(Iterable<String>allUrls)=> allUrls.getRandomElement();

  AppBloc({required Iterable<String>urls, Duration? waitBeforeDuration, AppBLocRandomUrlPicker? urlPicker}) : super(const AppState.empty(){
    on<LoadNextUrlEvent>((event, emit)async{
       emit(const AppState(isLoading: true, data: null, error:null));
       final url = (urlPicker?? _pickRandomUrl)(urls);
       AppBlocUrlLoader urlLoader;
       try{
         if(waitBeforeLoading !=null){
  await Future.delayed(waitBeforeDuration);
  }
         final bundle  = NetworkAssetBundle(Uri.parse(url));
         final data= (await bundle.load(url).buffer.asUnin8List());
         emit(isLoading: false, data :data, error: null);

  } 
  }catch(e){
         emit(isloading: false, error: e, data: null);
  }
  })
  });
}