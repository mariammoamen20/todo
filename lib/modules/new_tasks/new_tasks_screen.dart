import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/shared/components/components.dart';
import 'package:todo_app_flutter/shared/cubit/cubit.dart';
import 'package:todo_app_flutter/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
     builder: (context,state){
       var cubit = AppCubit.get(context);
       return ListView.separated(itemBuilder: (context,index)=>buildTaskItem(cubit.newTasks[index],context),
           separatorBuilder: (context,index)=>Padding(
             padding: const EdgeInsetsDirectional.only(start: 10.0,end: 10.0),
             child: Container(
               height: 1.0,
               width: double.infinity,
               color: Colors.grey,
             ),
           ),
           itemCount: cubit.newTasks.length);
     },
   );
  }
}
