import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../main.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
    // on<>();
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final docTask = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('tasks')
        .doc(task.myid);

    // // final int index = state.pendingTasks.indexOf(task);
    // List<Task> pendingTasks = state.pendingTasks;
    // List<Task> completedTasks = state.completedTasks;
    // List<Task> favoriteTasks = state.favoriteTasks;
    // if (task.isDone == false) {
    //   if (task.isFavorite == false) {
    //     //not Done and not Favorite
    //     pendingTasks = List.from(pendingTasks)..remove(task);
    //     completedTasks.insert(0, task.copyWith(isDone: true));
    //   } else {
    //     //not Done is Favorite
    //     var taskIndex = favoriteTasks.indexOf(task);
    //     pendingTasks = List.from(pendingTasks)..remove(task);
    //     completedTasks.insert(0, task.copyWith(isDone: true));
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..remove(task)
    //       ..insert(taskIndex, task.copyWith(isDone: true));
    //   }
    // } else {
    //   if (task.isFavorite == false) {
    //     //is Done not favorite
    //     completedTasks = List.from(completedTasks)..remove(task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..insert(0, task.copyWith(isDone: false));
    //   } else {
    //     //is Done and is Favorite
    //     var taskIndex = favoriteTasks.indexOf(task);
    //     completedTasks = List.from(completedTasks)..remove(task);
    //     pendingTasks = List.from(pendingTasks)
    //       ..insert(0, task.copyWith(isDone: false));
    //     favoriteTasks = List.from(favoriteTasks)
    //       ..remove(task)
    //       ..insert(taskIndex, task.copyWith(isDone: false));
    //   }
    // }
    // ;

    // emit(TasksState(
    //   pendingTasks: pendingTasks,
    //   completedTasks: completedTasks,
    //   favoriteTasks: favoriteTasks,
    //   removedTasks: state.removedTasks,
    // ));
    if (task.isDone == false) {
      docTask.update({
        'isDone': true,
      });
    } else {
      docTask.update({
        'isDone': false,
      });
    }
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        //pending and not favorite
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        //pending and favorite
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      //completed and not favorite
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        //completed and favorite
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
              0,
              event.task.copyWith(
                isDeleted: false,
                isDone: false,
                isFavorite: false,
              )),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: List.from(state.pendingTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks),
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
