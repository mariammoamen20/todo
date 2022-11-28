import 'package:flutter/material.dart';
import 'package:todo_app_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app_flutter/modules/new_tasks/new_tasks_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //اويت معناها استنى لحد ما الفنكشن دي تخلص وتديك الداتا
          String name = await getName();
          print(name);
        },
        child: const Icon(Icons.add),
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

  //ميثود عاديه جدا شغاله في المين ثريد
  /* String getName(){
    return 'Ahmed Ali';
  }*/
  //فيوتشر معناها ان الميثود راحت تشتغل في الباكجروند ثريد وهترجع بداتا ان شاء الله بس انا مش عارف هترجع امتى ولا هتاخد وقت قد ايه
  //فا علشان انا مش عارف وهي بتشتغل في الباكجروند ثريد فا هكون محتاح افتحلها ثريد تشتغل فيه عن طريق async
  Future<String> getName() async {
    return ' Ahmed Ali';
  }
}
