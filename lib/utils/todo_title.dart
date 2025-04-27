import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDolist extends StatelessWidget {
  const ToDolist({
    super.key,
    required this.taskName,
    required this.isDone,
    this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),

      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isDone,
                onChanged: onChanged,
                checkColor: Colors.white,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
