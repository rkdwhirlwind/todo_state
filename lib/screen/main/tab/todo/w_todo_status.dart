import 'package:todo_state/common/common.dart';
import 'package:todo_state/data/memory/bloc/todo_event.dart';
import 'package:todo_state/data/memory/todo_status.dart';
import 'package:todo_state/screen/main/tab/todo/w_fire.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoStatusWidget extends StatelessWidget  {
  final Todo todo;

  TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        context.readTodoBloc.add(TodoStatusUpdateEvent(todo));
      },
      child: SizedBox(
          width: 50,
          height: 50,
          child: switch (todo.status) {
            TodoStatus.complete => Checkbox(
                value: true,
                onChanged: null,
                fillColor: MaterialStateProperty.all(
                  context.appColors.checkBoxColor,
                ),
              ),
            TodoStatus.incomplete => const Checkbox(
                value: false,
                onChanged: null,
              ),
            TodoStatus.ongoing => const Fire()
          }),
    );
  }
}
