import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/bloc/top_bloc.dart';
import 'package:state_management/views/app_bloc_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(

          value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
            providers: [
              BlocProvider<TopBloc>(create: (_)=> TopBloc(urls:images, waitBeforeLoding: Duration(seconds: 3))),

            ],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBlocView(),
                AppBlocView()

              ],
            )

        ),
          )
    );
  }
}
