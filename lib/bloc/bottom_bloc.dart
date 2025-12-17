import 'package:state_management/bloc/app_bloc.dart';

class BottomBloc extends AppBloc {
  BottomBloc({ Duration? waitBeforeLoding, required Iterable<String>urls}): super
      (waitBeforeDuration: waitBeforeLoding, urls: urls);

}