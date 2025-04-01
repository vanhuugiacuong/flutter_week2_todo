import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  final String title;
  const AddToDo({super.key, required this.title});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (value) {
            setState(() {
              isDone = value!;
            });
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
