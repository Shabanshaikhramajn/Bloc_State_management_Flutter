import 'package:state_management/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({ Duration? waitBeforeLoding, required Iterable<String>urls}): super
      (waitBeforeDuration: waitBeforeLoding, urls: urls);

}