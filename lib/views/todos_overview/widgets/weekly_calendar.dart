part of 'todos_overview_body.dart';

class WeeklyCalendar extends StatelessWidget {
  WeeklyCalendar({
    super.key,
    String localeCode = 'en',
    required List<Todo> todos,
  })  : _localeCode = localeCode,
        _todos = todos;
  final String? _localeCode;
  final List<Todo> _todos;

  // The current date
  final DateTime _date = DateTime.now();

  // The index of the current day in the list
  final int _currentDayIndex = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    final List<String> days =
        DateFormat.E(_localeCode).dateSymbols.STANDALONESHORTWEEKDAYS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the current date, month, and year
          Text(
            '${DateFormat.MMMM(_localeCode).format(_date)} ${_date.year}',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ViewsConstant.gap18,
          // Display the days of the week in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => DayCard(
                index: (_currentDayIndex + index) % 7,
                day: days[(_currentDayIndex + index) % 7],
                dayDate: _date.add(Duration(days: index)).day.toString(),
                currentDayIndex: _currentDayIndex,
                numOfTasks: _todos.where(
                  (element) {
                    return element.dueDate != null &&
                        element.dueDate!.day.toString() ==
                            _date.add(Duration(days: index)).day.toString();
                  },
                ).length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required String day,
    required int currentDayIndex,
    required int index,
    required String dayDate,
    required int numOfTasks,
  })  : _day = day,
        _currentDayIndex = currentDayIndex,
        _index = index,
        _dayDate = dayDate,
        _numOfTasks = numOfTasks;

  final String _day;
  final int _currentDayIndex;
  final int _index;
  final String _dayDate;
  final int _numOfTasks;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodosOverviewBloc>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: MediaQuery.of(context).size.width / 8,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (context) {
              return BlocProvider.value(
                value: bloc,
                child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
                  builder: (context, state) {
                    final todos = state.todos.where((todo) =>
                        todo.dueDate != null &&
                        todo.dueDate!.day.toString() == _dayDate).toList();
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (ctx, index) {
                        final todo = todos[index];
                        return TodoListTile(
                          todo: todo,
                          onDismissed: (direction) {
                            ctx.read<TodosOverviewBloc>().add(
                                  TodosOverviewTodoDeleted(
                                    todo,
                                  ),
                                );
                          },
                          onToggleCompleted: (isCompleted) {
                            ctx.read<TodosOverviewBloc>().add(
                                  TodosOverviewTodoCompletionToggled(
                                    todo: todo,
                                    isCompleted: isCompleted,
                                  ),
                                );
                          },
                          onTap: () => Navigator.push(
                            ctx,
                            TodoDetailsPage.route(todo),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
        child: Column(
          children: [
            Text(
              _day,
              style: TextStyle(
                fontSize: 14,
                // Highlight the current day with a different color
                color: _index == _currentDayIndex
                    ? isDark
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inversePrimary
                    : null,
              ),
            ),
            ViewsConstant.gap12,
            Text(
              _dayDate,
              style: TextStyle(
                color: _index == _currentDayIndex
                    ? isDark
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inversePrimary
                    : null,
              ),
            ),
            Visibility(
              visible: _numOfTasks != 0,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
