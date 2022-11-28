import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app_flutter/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app_flutter/shared/components/components.dart';

//دي السكرينه اللي هتشيل كل السكرينز الباقيه
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  //لو محتاجه اعمل توجل بين حاجتين هعمل كده عن طريق boolean true and false
  //لو محتاجه اعمل توجل بين اكتر من حاجتين هعمل كده عن طريق list
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
  var scaffoldKey = GlobalKey<ScaffoldState>();

  //هو المفروض بيبقى مقفول اول ما بفتح الاب
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  late Database database;
  var titleController = TextEditingController();
  var timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //عملتها هنا علشان دي بتتكريت اول ما برن الاب وبتتنفذ قبل البيلد
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //لو هو بترو اقفل وخليه بفولس علشان لما يبقى فولس يروح على else ويفتحه
          if (isBottomSheetShown) {
            Navigator.pop(context);
            setState(() {
              isBottomSheetShown = false;
              fabIcon = Icons.edit;
            });
          }
          //لو البوتمشيت مش مفتوح يعني ب فولس روح افتحه وخليه ترو علشان يروح يقفله ويخليه بفولس
          else {
            scaffoldKey.currentState?.showBottomSheet((context) => Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultTextFormFiled(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'title must not be empty';
                            }
                          },
                          controller: titleController,
                          label: 'Task Title',
                          prefixIcon: Icons.title,
                          type: TextInputType.text),
                      const SizedBox(
                        height: 5,
                      ),
                      defaultTextFormFiled(
                          onTap: () {
                            print('timing tapped');
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'data must not be empty';
                            }
                          },
                          controller: timeController,
                          label: '20.30',
                          prefixIcon: Icons.timer,
                          type: TextInputType.text),
                    ],
                  ),
                ));
            setState(() {
              isBottomSheetShown = true;
              fabIcon = Icons.add;
            });
          }
          /*//اويت معناها استنى لحد ما الفنكشن دي تخلص وتديك الداتا
          */ /*String name = await getName();
          print(name);*/ /*

          //try catch
          */ /*  try{
            String name = await getName();
            print(name);
            print('osama');
            throw('some error !!!');
          }catch(error){
             print('error ${error.toString()}');
          }*/ /*

          getName().then((value) {
            //الفاليو دي اللي هي الريزلت بتاعت الميثود اللي اسمها جيت نيم
            print(value);
            throw ('some error !!!');
          }).catchError((error){
            print('error ${error.toString()}');
          });*/
          //insertToDatabase();
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          //مينفعش اعمل في bottom navigation bar ايتم واحد بس
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Done Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
      ),
      body: screens[currentIndex],
    );
  }

  //هنعمل هنا الداتا بيز علشان الهوم لاي اوت هيكون على مستوى الاب هفضل واقف فيه والداتا اللي هترجعلي هوزعها وانا محتاج اكريت الداتا بيز مره واحده بس

/*  //ميثود عاديه جدا شغاله في المين ثريد
  */ /* String getName(){
    return 'Ahmed Ali';
  }*/ /*
  //فيوتشر معناها ان الميثود راحت تشتغل في الباكجروند ثريد وهترجع بداتا ان شاء الله بس انا مش عارف هترجع امتى ولا هتاخد وقت قد ايه
  //فا علشان انا مش عارف وهي بتشتغل في الباكجروند ثريد فا هكون محتاح افتحلها ثريد تشتغل فيه عن طريق async
  Future<String> getName() async {
    return ' Ahmed Ali';
  }*/
  void createDatabase() async {
    //openDatabase Future<Database> علشان كده لازم اسينك واويت
    database = await openDatabase(
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
      debugPrint('database opened');
    });
  }

  void insertToDatabase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title , data , time , status ) VALUES("first task","28/11/2022","20.31","new")')
          .then((value) {
        print('$value Inserted Successfully');
      }).catchError((error) {
        print('Error When Creating Tabel ${error.toString()}');
      });
      throw '';
    });
  }
}
