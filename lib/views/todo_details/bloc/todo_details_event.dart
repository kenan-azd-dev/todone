part of 'todo_details_bloc.dart';

sealed class TodoDetailsEvent extends Equatable {
  const TodoDetailsEvent();

  @override
  List<Object> get props => [];
}

final class TodoDetailsSubscriptionRequested extends TodoDetailsEvent {
  const TodoDetailsSubscriptionRequested(this.id);
  
  final String id;
  
  @override
  List<Object> get props => [id];
}
