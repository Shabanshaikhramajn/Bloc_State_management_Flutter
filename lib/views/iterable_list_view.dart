import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IterableListView<T> extends StatelessWidget {
  final Iterable<T> iterable;
   IterableListView({super.key, required this.iterable});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: iterable.length,
        itemBuilder: (context,index){
        return ListTile(
          title: Text(iterable.elementAt(index).toString()),
        );
    });
  }
}
