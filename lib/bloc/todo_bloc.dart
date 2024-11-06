import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_event.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_state.dart';
import 'package:todo_list_bloc_flutter/models/task.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Task> tasks = [];
  TodoBloc() : super(TodoLoading()) {
    on<LoadTasks>((event, emit) {
      emit(TodoLoaded(tasks: tasks));
    });

    on<AddTask>(
      (event, emit) {
        Task newTask = Task(name: event.name);

        tasks.add(newTask);
        emit(TodoLoaded(tasks: tasks));

        print('Current Tasks:');
        tasks.forEach((task) => print(task.name));
      },
    );

    on<CompleteTask>(
      (event, emit) {
        List<Task> newList = tasks.map((task) {
          if (task == event.task) {
            return task.copyWith(isDone: true);
          }
          return task;
        }).toList();
        emit(TodoLoaded(tasks: newList));
      },
    );

    on<DeleteTask>(
      (event, emit) {
        tasks.remove(event.task);
        emit(TodoLoaded(tasks: tasks));
      },
    );
  }
}
