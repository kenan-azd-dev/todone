// Package
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository/todos_repository.dart';

// Project
part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  TodoDetailsBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodoDetailsState()) {
    on<TodoDetailsSubscriptionRequested>(_onSubscriptionRequested);
  }
  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    TodoDetailsSubscriptionRequested event,
    Emitter<TodoDetailsState> emit,
  ) async {
    emit(state.copyWith(status: () => TodoDetailsStatus.loading));

    // ? That might not be the ideal way to fetch 
    // ? a single todo and subscribe to it, but since
    // ? it's a simple project, it's not a big deal. 
    await emit.forEach<Todo>(
      _todosRepository
          .getTodos()
          .map((todos) => todos.firstWhere((todo) => todo.id == event.id)),
      onData: (todo) => state.copyWith(
        status: () => TodoDetailsStatus.success,
        todo: () => todo,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodoDetailsStatus.failure,
      ),
    );
  }
}
