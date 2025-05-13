import 'package:flutter/material.dart';
import '../models/task.dart';


class TaskForm extends StatefulWidget {
  final Function(Task) onSubmit;
  final Task? initialTask;

  TaskForm({required this.onSubmit, this.initialTask});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _titleController.text = widget.initialTask!.title;
      _descController.text = widget.initialTask!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: _descController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        ElevatedButton(
onPressed: () {
  final id = widget.initialTask?.id ?? DateTime.now().millisecondsSinceEpoch;
  final task = Task(
    id: id,
    title: _titleController.text,
    description: _descController.text,
    status: widget.initialTask?.status ?? 'Pending',
    createdAt: widget.initialTask?.createdAt ?? DateTime.now(),
    priority: widget.initialTask?.priority ?? 'Normal',
  );
  widget.onSubmit(task);
  Navigator.of(context).pop();
},

          child: Text(widget.initialTask == null ? 'Add' : 'Update'),
        )
      ],
    );
  }
}
