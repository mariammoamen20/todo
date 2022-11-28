import 'package:flutter/material.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //مش هحط هنا سكفولد علشان هي كوجوده اوردي في home layout
    return const Center(
      child: Text('Done Tasks',style: TextStyle(
        fontSize: 30
      ),),
    );
  }
}
