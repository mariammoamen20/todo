import 'package:flutter/material.dart';
import 'package:todo_app_flutter/shared/cubit/cubit.dart';

Widget defaultTextFormFiled({
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  required String? Function(String?)? validator,
  required TextEditingController controller,
  required String label,
  required IconData? prefixIcon,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixPressed,
  required TextInputType? type,
  void Function()? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          ),
          border: const OutlineInputBorder(),
          hintText: label),
    );

Widget buildTaskItem(Map model,context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${model['data']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'done', id: model['id']);
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'archive', id: model['id']);
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
