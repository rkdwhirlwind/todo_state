import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_state/data/memory/bloc/bloc_status.dart';
import 'package:todo_state/data/memory/vo_todo.dart';

// CopyWith를 사용하면 BlocState를 사용할 때마다 만들어줘야 하기 때문에 CopyWith 대신 @freezed를 사용
part 'todo_bloc_state.freezed.dart'; // 이후 'flutter pub run build_runner build' 명령어 수행
@freezed
class TodoBlocState with _$TodoBlocState {
  const factory TodoBlocState(
      List<Todo> todoList,
      BlocStatus status,
      ) = _TodoBlocState;
  // final List<Todo> todoList;
  // final BlocStatus status;
}