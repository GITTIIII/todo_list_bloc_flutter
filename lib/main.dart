import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_bloc.dart';
import 'package:todo_list_bloc_flutter/page/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => TodoBloc(),
        )
      ], child: const TodoPage()),
    );
  }
}
