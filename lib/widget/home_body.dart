import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_manager/bloc/todo_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
        bloc: BlocProvider.of<TodoBloc>(context),
        builder: (_, state) {
          debugPrint('${state.todos}');
          if (state.todos.isNotEmpty) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(state.todos[i].title),
                subtitle: Text(state.todos[i].subtitle),
                trailing: Text('${state.todos[i].count}'),
              ),
            );
          }
          return const Center(
            child: Text("Liste Vide"),
          );
        });
  }
}
