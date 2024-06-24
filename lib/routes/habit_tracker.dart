import 'package:flutter/material.dart';
import 'package:happit/components/month_summary.dart';
import 'package:happit/data/database.dart';
import 'package:happit/routes/footer_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../components/habit_tile.dart';
import '../components/my_alert_box.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() => _HomePageState();
}

class _HomePageState extends State<HabitTracker> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('Habit_Database');

  @override
  void initState() {
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabits[index][1] = value!;
    });
    db.updateDatabase();
  }

  final _newHabitController = TextEditingController();

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitController,
            hintText: 'Enter New Habit...',
            onSave: saveNewHabit,
            onCancel: cancelDialogBox,
          );
        });
    db.updateDatabase();
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabits.add([_newHabitController.text, false]);
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabits[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void openDeleteSettings(int index) {
    setState(() {
      db.todaysHabits.removeAt(index);
    });
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitController,
          hintText: db.todaysHabits[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.checklist),
            SizedBox(
              width: 8,
            ),
            Text('Habit Tracker'),
          ],
        ),
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewHabit, child: const Icon(Icons.add)),
      body: ListView(
        children: [
          MonthlySummary(
            datasets: db.heatMapDataSet,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabits.length,
            itemBuilder: (context, index) {
              return HabitTile(
                  habitName: db.todaysHabits[index][0],
                  habitCompleted: db.todaysHabits[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => openDeleteSettings(index));
            },
          ),
        ],
      ),
      bottomNavigationBar: CommonFooterMenu(context).getFooterMenu(0),
    );
  }
}
