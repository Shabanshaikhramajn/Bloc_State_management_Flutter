import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_management/dialogs/loading_screen_controller.dart';

class LoadingScreen {

  LoadingScreen._sharedInstance();

  //singeleton pattern
  static late final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text
}){
    if(_controller?.update(text) ?? false){
      return ;
    } else {
      _controller =  _showOverlay(context: context, text: text);
    }
  }

  void hide (){
    _controller?.close;
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text
   }){
     final _text = StreamController<String>();
     _text.add(text);
     final state =  Overlay.of(context);
     final renderBox = context.findRenderObject() as RenderBox;
     final size = renderBox.size;

     final overlay =  OverlayEntry(
       builder: (context){
         return Material(
           color: Colors.black.withAlpha(150),
           child: Center(
             child: Container(
               constraints: BoxConstraints(
                 maxWidth: size.width *.8,
                 maxHeight: size.height*.8,
                 minWidth: size.width*.5

               ),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10)
               ),
               padding: EdgeInsets.all(16),
               child:  SingleChildScrollView(
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: 10,
                     ),
                     CircularProgressIndicator(),
                     SizedBox(height: 20),
                     StreamBuilder<String>(stream: _text.stream, builder: (context,snapshot){
                       if(snapshot.hasData){
                         return Text(
                           snapshot.data!,
                           textAlign: TextAlign.center,
                         );
                       }else{
                         return Container();
                       }
                       
                     })
                   ],
                 ),
               ),
             ),
           ),
         );
       }
     );
     state?.insert(overlay);
     return LoadingScreenController(close: (){
       _text.close();
       overlay.remove();
       return true;
     }, update: (text){
       _text.add(text);
       return true;
     });
  }




}