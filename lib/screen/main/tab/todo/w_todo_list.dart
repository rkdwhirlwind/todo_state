import 'package:todo_state/common/common.dart';
import 'package:todo_state/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.holder.notifier,
      builder: (context, todoList, child) {
        return todoList.isEmpty
            ? '할일을 작성해보세요.'.text.size(30).makeCentered()
            : Column(
                children: todoList.map((e) => TodoItem(e)).toList(),
              );
      },
    );
  }
}
