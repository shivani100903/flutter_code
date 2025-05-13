import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../widgets/task_form.dart';
import '../models/task.dart';

class TaskScreen extends StatelessWidget {
  void _openForm(BuildContext context, [Task? task]) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TaskForm(
        initialTask: task,
        onSubmit: (taskData) {
          if (task == null) {
            context.read<TaskBloc>().add(AddTask(taskData));
          } else {
            context.read<TaskBloc>().add(UpdateTask(taskData));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task CRUD'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return Center(child: Text('No tasks yet.'));
          }
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _openForm(context, task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => context.read<TaskBloc>().add(DeleteTask(task.id)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
