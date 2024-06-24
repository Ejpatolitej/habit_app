import 'package:happit/datetime/datetime.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myHabitBox = Hive.box('Habit_Database');
final _myTodoBox = Hive.box('Todo_Database');

class TodoDatabase {
  List todoList = [];

  void createDefaultData() {
    todoList = [
      ['Study', false],
      ['Brush teeth', false],
    ];
  }

  void loadData() {
    if (_myTodoBox.get(todaysDateFormatted()) == null) {
      todoList = _myTodoBox.get('CURRENT_TODO_LIST');
      for (var i = 0; i < todoList.length; i++) {
        todoList[i][1] = false;
      }
    } else {
      todoList = _myTodoBox.get(todaysDateFormatted());
    }
  }

  void updateDatabase() {
    _myTodoBox.put(todaysDateFormatted(), todoList);
    _myTodoBox.put('CURRENT_TODO_LIST', todoList);
  }
}

class HabitDatabase {
  List todaysHabits = [];
  Map<DateTime, int> heatMapDataSet = {};

  //Initial data
  void createDefaultData() {
    todaysHabits = [
      ['Study', false],
      ['Brush teeth', false],
    ];
    _myHabitBox.put('START_DATE', firstOfMonth());
  }

  void loadData() {
    if (_myHabitBox.get(todaysDateFormatted()) == null) {
      todaysHabits = _myHabitBox.get('CURRENT_HABIT_LIST');
      for (int i = 0; i < todaysHabits.length; i++) {
        todaysHabits[i][1] = false;
      }
    } else {
      todaysHabits = _myHabitBox.get(todaysDateFormatted());
    }
    loadHeatMap();
  }

  void updateDatabase() {
    _myHabitBox.put(todaysDateFormatted(), todaysHabits);
    _myHabitBox.put('CURRENT_HABIT_LIST', todaysHabits);
    calculateHabitPercentages();
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabits.length; i++) {
      if (todaysHabits[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = todaysHabits.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabits.length).toStringAsFixed(1);

    _myHabitBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percent);
  }

  void loadHeatMap() {
    DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime endDate =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
            .subtract(const Duration(days: 1));

    for (DateTime date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      String yyyymmdd = convertDateTimeToString(date);

      double strengthAsPercent = double.parse(
          _myHabitBox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0');

      final percentageForEachDay = <DateTime, int>{
        date: (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentageForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
