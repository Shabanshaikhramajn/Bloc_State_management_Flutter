// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:state_management/bloc/bloc_actions.dart';
// import 'package:state_management/bloc/person.dart';
// import 'package:state_management/bloc/persons_bloc.dart';
//
// const mockerPersons1 = [
//   Person(name: 'Foo', age: 20),
//   Person(name: 'bar', age: 30)
// ];
//
// const mockerPersons2 = [
//   Person(name: 'Foo', age: 20),
//   Person(name: 'bar', age: 30)
// ];
//
// Future<Iterable<Person>> mockGetPerson1 (String _)=>
//     Future.value(mockerPersons1);
//
//
// Future<Iterable<Person>> mockGetPerson2 (String _)=>
//     Future.value(mockerPersons2);
//
// void main(){
//   group('Testing bloc', (){
//      late PersonBloc bloc;
//      setUp((){
//        bloc = PersonBloc();
//      });
//      blocTest<PersonBloc, FetchResults?>('Test Initial state', build: ()=>bloc,
//      verify: (bloc)=>bloc.state == null,
//      );
//
//      //fetch mock data (person1) and compare it with fetchresult
//     blocTest('Mock Retrieving person rom first iterable', build: ()=> bloc,
//     act:(bloc){
//       bloc.add(LoadPersonAction(url: 'dummy_url1', loader: mockerPersons1));
//     }
//     );
//   });
// }