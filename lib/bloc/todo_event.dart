import 'package:todo_list_bloc_flutter/models/task.dart';

abstract class TodoEvent {}

class LoadTasks extends TodoEvent {
  
}

class AddTask extends TodoEvent {
  final String name;

  AddTask(this.name);
}

class CompleteTask extends TodoEvent {
  final Task task;

  CompleteTask(this.task);
}

class DeleteTask extends TodoEvent {
  final Task task;

  DeleteTask(this.task);
}
