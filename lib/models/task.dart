class Task{
  Task({required this.name, this.isDone = false});
  String name;
  bool isDone;

  Task copyWith({String? name, bool? isDone}) {
    return Task(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}