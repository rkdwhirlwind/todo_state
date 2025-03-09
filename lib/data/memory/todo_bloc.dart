import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_state/data/memory/bloc/bloc_status.dart';
import 'package:todo_state/data/memory/bloc/todo_bloc_state.dart';
import 'package:todo_state/data/memory/bloc/todo_event.dart';
import 'package:todo_state/data/memory/todo_status.dart';
import 'package:todo_state/data/memory/vo_todo.dart';
import 'package:todo_state/screen/dialog/d_confirm.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/main/write/d_write_todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {

  /// 파라미터 없이 받아서 내부에서 super를 처리하도록 변경
  TodoBloc() : super(const TodoBlocState(<Todo>[], BlocStatus.initial)){
    on<TodoAddEvent>(_addTodo);
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoContentUpdateEvent>(_editTodo);
    on<TodoRemovedEvent>(_removeTodo);
  }

  void _addTodo(TodoAddEvent event, Emitter<TodoBlocState> emit) async {
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
      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _changeTodoStatus(TodoStatusUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todo = event.updatedTodo;
    final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);
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
    emitNewList(copiedOldTodoList, emit);
  }

  void _editTodo(TodoContentUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final todo = event.updatedTodo;
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      //todo.title = result.text;
      //todo.dueDate = result.dateTime;

      final oldCopiedList = List<Todo>.from(state.todoList);
      oldCopiedList[oldCopiedList.indexOf(todo)] = todo.copyWith(
          title: result.text,
          dueDate: result.dateTime,
          modifyTime: DateTime.now());
      emitNewList(oldCopiedList, emit);
    }
  }

  void _removeTodo(TodoRemovedEvent event, Emitter<TodoBlocState> emit) {
    final oldCopiedList = List<Todo>.from(state.todoList);
    final todo = event.removedTodo;
    oldCopiedList.removeWhere((element) => element.id == todo.id);
    emitNewList(oldCopiedList, emit);
  }

  void emitNewList(List<Todo> oldCopiedList, Emitter<TodoBlocState> emit) {
    emit(state.copyWith(todoList: oldCopiedList));
  }
}

//mixin class TodoDataProvider {
//  late final TodoCubit todoData = Get.find();
//}
