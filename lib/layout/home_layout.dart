import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_flutter/shared/components/components.dart';
import 'package:todo_app_flutter/shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertToDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);
                      cubit.changeBottomSheet(isShown: false, icon: Icons.edit);
                    }
                  }
                  else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                            (context) => Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //task title
                                        defaultTextFormFiled(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'title must not be empty';
                                              }
                                            },
                                            controller: titleController,
                                            label: 'Task title',
                                            prefixIcon: Icons.title,
                                            type: TextInputType.text),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        //task time
                                        defaultTextFormFiled(
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                timeController.text =
                                                    value!.format(context);
                                                //print(value?.format(context));
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'time must not be empty';
                                              }
                                            },
                                            controller: timeController,
                                            label: 'Task Time',
                                            prefixIcon: Icons.timer,
                                            type: TextInputType.datetime),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        //task date
                                        defaultTextFormFiled(
                                            onTap: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2023-01-01'))
                                                  .then((value) {
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!);
                                                //print(DateFormat.yMMMd().format(value!));
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'date must not be empty';
                                              }
                                            },
                                            controller: dateController,
                                            label: 'Task Date',
                                            prefixIcon:
                                                Icons.calendar_today_outlined,
                                            type: TextInputType.datetime),
                                      ],
                                    ),
                                  ),
                                ),
                            elevation: 30.0)
                        .closed
                        .then((value) {
                      cubit.changeBottomSheet(isShown: false, icon: Icons.edit);
                    });
                    cubit.changeBottomSheet(isShown: true, icon: Icons.add);
                  }
                  //insertToDatabase();
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  //on tap with bloc
                  cubit.changeIndex(index);
                },
                items: const [
                  //مينفعش اعمل في bottom navigation bar ايتم واحد بس
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline),
                      label: 'Done Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archived'),
                ],
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ));
  }



}
