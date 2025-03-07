import 'package:get/get.dart';
import 'package:todo_state/data/memory/todo_status.dart';
import 'package:todo_state/data/memory/vo_todo.dart';
import 'package:todo_state/screen/dialog/d_confirm.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/main/write/d_write_todo.dart';

//class TodoDataHolder extends InheritedWidget {
class TodoDataHolder extends GetxController {
  //final TodoDataNotifier notifier;
  final RxList<Todo> todoList = <Todo>[].obs;
/*
  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  // Private 함수로 변경
  static TodoDataHolder _of(BuildContext context) {
    TodoDataHolder inherited = (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }
*/
  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    //notifier.notify();
    todoList.refresh();
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      //notifier.addTodo(Todo(
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      //notifier.notify();
      todoList.refresh();
    }
  }

  void removeTodo(Todo todo) {
    //notifier.value.remove(todo);
    //notifier.notify();
    todoList.remove(todo);
    todoList.refresh();
  }
}

mixin class TodoDataProvider {
  late final TodoDataHolder todoData = Get.find();
}

/// TodoDataHolder를 강제하기 위해 직접 BuildContext의 extension을 생성
/// (context_extension.dart에서 만들시 동일한 기능을 사람마다 서로 다르게 선언할 수 있기 때문)
/*extension TodoDataHolderContextExtension on BuildContext {
  TodoDataHolder get holder => TodoDataHolder._of(this);
}*/