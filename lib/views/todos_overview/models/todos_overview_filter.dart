import 'package:todos_repository/todos_repository.dart';

/// Defines the different filter options available for displaying todos.
enum TodosViewFilter {
  /// Shows all todos, regardless of completion status.
  all,

  /// Shows only active (not completed) todos.
  activeOnly,

  /// Shows only completed todos.
  completedOnly,
}

/// Extension methods for the `TodosViewFilter` enum.
extension TodosViewFilterX on TodosViewFilter {
  /// Checks if a specific `Todo` item matches the current filter criteria.
  ///
  /// This method implements the logic for filtering todos based on the
  /// selected filter.
  ///
  /// Returns:
  ///   `true` if the todo matches the filter, `false` otherwise.
  bool apply(Todo todo) {
    switch (this) {
      case TodosViewFilter.all:
        return true;
      case TodosViewFilter.activeOnly:
        return !todo.isCompleted;
      case TodosViewFilter.completedOnly:
        return todo.isCompleted;
    }
  }

  /// Applies the current filter to a collection of todos.
  ///
  /// This method uses the `apply` method to filter the provided iterable
  /// of `Todo` objects based on the selected filter.
  ///
  /// Returns:
  ///   A new iterable containing only the todos that match the filter.
  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
