import 'package:flutter/material.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //مش هحط هنا سكفولد علشان هي كوجوده اوردي في home layout
    return const Center(
      child: Text('Archived Tasks',style: TextStyle(
        fontSize: 30
      ),),
    );
  }
}
