import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //مش هحط هنا سكفولد علشان هي كوجوده اوردي في home layout
    return const Center(
      child: Text('New Tasks ',style: TextStyle(
        fontSize: 30
      ),),
    );
  }
}
