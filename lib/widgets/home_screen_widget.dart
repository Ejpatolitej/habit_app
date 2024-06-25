import 'package:flutter/material.dart';
import 'package:happit/data/database.dart';
import 'package:happit/components/my_alert_box.dart';
import 'package:happit/components/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  TodoDatabase db = TodoDatabase();
  final _myBox = Hive.box('Todo_Database');

  @override
  void initState() {
    if (_myBox.get('CURRENT_TODO_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value!;
    });
    db.updateDatabase();
  }

  final _newTodoController = TextEditingController();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newTodoController,
          onSave: saveNewTask,
          onCancel: cancelDialogBox,
          hintText: 'Enter New Task...',
        );
      },
    );
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_newTodoController.text, false]);
    });
    _newTodoController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void saveExistingTask(int index) {
    setState(() {
      db.todoList[index][0] = _newTodoController.text;
    });
    _newTodoController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newTodoController.clear();
    Navigator.of(context).pop();
  }

  void openDeleteSettings(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void openSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newTodoController,
          onSave: () => saveExistingTask(index),
          onCancel: cancelDialogBox,
          hintText: db.todoList[index][0],
        );
      },
    );
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.check_box),
            SizedBox(
              width: 8,
            ),
            Text('To Do'),
          ],
        ),
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            settingsTapped: (context) => openSettings(index),
            deleteTapped: (context) => openDeleteSettings(index),
          );
        },
      ),
    );
  }
}
