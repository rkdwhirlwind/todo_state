import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_state/data/memory/bloc/bloc_status.dart';
import 'package:todo_state/data/memory/bloc/todo_bloc_state.dart';
import 'package:todo_state/data/memory/todo_status.dart';
import 'package:todo_state/data/memory/vo_todo.dart';
import 'package:todo_state/screen/dialog/d_confirm.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/main/write/d_write_todo.dart';

//class TodoDataHolder extends GetxController {
class TodoCubit extends Cubit<TodoBlocState> {
  //final RxList<Todo> todoList = <Todo>[].obs;

  //TodoCubit(super.initialState);
  /// 파라미터 없이 받아서 내부에서 super를 처리하도록 변경
  TodoCubit() : super(const TodoBlocState(<Todo>[], BlocStatus.initial));

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      //notifier.addTodo(Todo(
      copiedOldTodoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
        createdTime: DateTime.now(),
        status: TodoStatus.incomplete,
      ));
      emitNewList(copiedOldTodoList);
    }
  }

  void changeTodoStatus(Todo todo) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todoIndex =
        copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }

    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emitNewList(copiedOldTodoList);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      //todo.title = result.text;
      //todo.dueDate = result.dateTime;

      final oldCopiedList = List<Todo>.from(state.todoList);
      oldCopiedList[oldCopiedList.indexOf(todo)] = todo.copyWith(
          title: result.text,
          dueDate: result.dateTime,
          modifyTime: DateTime.now());
      emitNewList(oldCopiedList);
    }
  }

  void removeTodo(Todo todo) {
    final oldCopiedList = List<Todo>.from(state.todoList);
    oldCopiedList.removeWhere((element) => element.id == todo.id);
    emitNewList(oldCopiedList);
  }

  void emitNewList(List<Todo> oldCopiedList) {
    emit(state.copyWith(todoList: oldCopiedList));
  }
}

//mixin class TodoDataProvider {
//  late final TodoCubit todoData = Get.find();
//}
