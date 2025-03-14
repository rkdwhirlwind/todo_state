import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:todo_state/common/common.dart';
import 'package:todo_state/data/memory/bloc/todo_bloc_state.dart';
import 'package:todo_state/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';

// GetView를 사용하게 되면 TodoDataHolder 외 다른 Controller가 필요할 때
// 새로 선언해서 불필요한 코드스멜이 발생될 수 있음
class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(builder: (context, state) {
      return state.todoList.isEmpty
          ? '할일을 작성해보세요.'.text.size(30).makeCentered()
          : Column(
              children:
                  //controller.todoList.map((e) => TodoItem(e)).toList(),
                  state.todoList.map((e) => TodoItem(e)).toList(),
            );
    });
    /* return Obx(
      () => //controller.todoList.isEmpty
            todoData.todoList.isEmpty
              ? '할일을 작성해보세요.'.text.size(30).makeCentered()
              : Column(
                  children:
                      //controller.todoList.map((e) => TodoItem(e)).toList(),
                      todoData.todoList.map((e) => TodoItem(e)).toList(),
                ),
    ); */
  }
}
