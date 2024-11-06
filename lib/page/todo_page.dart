import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_bloc.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_event.dart';
import 'package:todo_list_bloc_flutter/bloc/todo_state.dart';
import 'package:todo_list_bloc_flutter/models/task.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  TextEditingController taskController = TextEditingController();
  late TodoBloc todoBloc;
  late List<Task> tasks;
  String name = '';

  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          Future.delayed(const Duration(seconds: 3), () {
            todoBloc.add(LoadTasks());
          });
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodoLoaded) {
          tasks = state.tasks;
          print(tasks);
          return Scaffold(
            appBar: AppBar(title: const Text('Todo List')),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => name = value,
                    controller: taskController,
                    decoration: const InputDecoration(labelText: 'Enter Task'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (name.isEmpty) return;
                      todoBloc.add(AddTask(name));
                      taskController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('Add Task')),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index].name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check,
                                  color: tasks[index].isDone
                                      ? Colors.green
                                      : Colors.grey),
                              onPressed: () {
                                todoBloc.add(CompleteTask(tasks[index]));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                todoBloc.add(DeleteTask(tasks[index]));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
