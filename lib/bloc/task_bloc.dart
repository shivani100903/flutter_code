import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';

 


abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final int taskId;
  DeleteTask(this.taskId);
}

class TaskState {
  final List<Task> tasks;
  TaskState(this.tasks);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState([])) {
    on<AddTask>((event, emit) {
      final updated = List<Task>.from(state.tasks)..add(event.task);
      emit(TaskState(updated));
    });

    on<UpdateTask>((event, emit) {
      final updated = state.tasks.map((t) =>
        t.id == event.task.id ? event.task : t).toList();
      emit(TaskState(updated));
    });

    on<DeleteTask>((event, emit) {
      final updated = state.tasks.where((t) => t.id != event.taskId).toList();
      emit(TaskState(updated));
    });
  }
}
