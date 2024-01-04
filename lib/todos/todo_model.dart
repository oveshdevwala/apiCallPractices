// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDoDataModel {
  int total;
  int skip;
  int limit;
  List<TodoModel> todos;
  ToDoDataModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.todos,
  });
  factory ToDoDataModel.fromJson(Map<String, dynamic> json) {
    List<TodoModel> listToDos = [];
    for (Map<String, dynamic> eachMap in json['todos']) {
      var todos = TodoModel.fromJson(eachMap);
      listToDos.add(todos);
    }
    return ToDoDataModel(
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
        todos: listToDos);
  }
}

class TodoModel {
  int id;
  String todo;
  bool completed;
  int userId;
  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'],
        todo: json['todo'],
        completed: json['completed'],
        userId: json['userId']);
  }
}
