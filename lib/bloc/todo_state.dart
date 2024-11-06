import 'package:todo_list_bloc_flutter/models/task.dart';

abstract class TodoState {}


class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Task> tasks;

  TodoLoaded({required this.tasks});
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
