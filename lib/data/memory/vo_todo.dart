import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo_status.dart';
/*
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.status = TodoStatus.incomplete,
  }) : createdTime = DateTime.now(); // Todo가 생성되는 시점에 createdTime 생성

  int id;
  String title;
  final DateTime createdTime;
  DateTime? modifyTime;
  DateTime dueDate;
  TodoStatus status;
}
*/

part 'vo_todo.freezed.dart'; // flutter pub run build_runner build

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required DateTime createdTime,
    DateTime? modifyTime,
    required DateTime dueDate,
    required TodoStatus status,
  }) = _Todo;
}
