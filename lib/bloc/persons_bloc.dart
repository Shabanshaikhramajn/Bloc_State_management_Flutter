import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_management/bloc/bloc_actions.dart';
import 'package:state_management/bloc/person.dart';
import 'package:state_management/main.dart';
import 'package:flutter/foundation.dart' show immutable;

extension IsEqualIgnoringOrdering<T> on Iterable<T>{
  bool isEqualToIgnoringOrdering(Iterable<T>other)=>
      length == other.length &&
          {...this}.intersection({...other}).length == length;
}


@immutable
class FetchResults {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  FetchResults({required this.persons,
    required this.isRetrievedFromCache});

  @override
  String toString()=>
      'FetchResult (isRetrievedFromCache  = $isRetrievedFromCache, persons =$persons';

  @override
  bool operator ==(covariant FetchResults other)=>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrievedFromCache == other.isRetrievedFromCache;


  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
  
}


class PersonBloc extends Bloc<LoadAction, FetchResults?>{
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc(): super(null){
    on<LoadPersonAction>((event, emit)async{
      final url = event.url;
      if(_cache.containsKey(url)){
        //   we have the value in the cache
        final cachedPersons = _cache[url]!;
        final result = FetchResults(persons: cachedPersons, isRetrievedFromCache: true);
        emit(result);
      }else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url]=  persons;
        final result = FetchResults(persons: persons, isRetrievedFromCache: false);
        emit(result);
      }
    });

  }
}
