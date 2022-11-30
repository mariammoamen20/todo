import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_flutter/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    //openDatabase Future<Database> علشان كده لازم اسينك واويت
    openDatabase(
        //اسم الفيل او اسم الداتا بيز
        'todo.db',
        version: 1,
        //create databse
        onCreate: (database, version) {
      debugPrint('database created');
      //create table
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , data TEXT , time TEXT , status TEXT )')
          .then((value) {
        debugPrint('table created');
      }).catchError((error) {
        debugPrint('Error When Creating Tabel ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      debugPrint('database opened');
    }).then((value) {
      //value and database are same objects from database
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String date,
      required String time}) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title , data , time , status ) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(AppInsertToDatabaseState());
        //بعد ما بعمل انسيرت بروح  اعمل جيت لداتا دي في السكرين بتاعت نيو تاسك
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Creating Tabel ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
    ;
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({required bool isShown, required IconData icon}) {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(AppChangeBottomNavBarState());
  }

  void updateDate({required String status, required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      status,
      id,
    ]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateState());
    });
  }
}
