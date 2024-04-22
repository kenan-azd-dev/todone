part of 'todo_details_bloc.dart';

enum TodoDetailsStatus { initial, loading, success, failure }

@immutable
class TodoDetailsState extends Equatable {
  final Todo? todo;
  final TodoDetailsStatus status;
  const TodoDetailsState({
    this.todo,
    this.status = TodoDetailsStatus.initial,
  });

  TodoDetailsState copyWith({
    Todo Function()? todo,
    TodoDetailsStatus Function()? status,
  }) {
    return TodoDetailsState(
      todo: todo != null ? todo() : this.todo,
      status: status != null ? status() : this.status,
    );
  }

  @override
  String toString() => 'TodoDetailsState(todo: $todo, status: $status)';

  @override
  List<Object?> get props => [todo, status];
}
