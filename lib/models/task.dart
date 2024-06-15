// import 'dart:convert';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String myid;
  final String date;
  final String category;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task({
    required this.title,
    required this.description,
    required this.myid,
    required this.date,
    required this.category,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    String? myid,
    String? date,
    String? category,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      myid: myid ?? this.myid,
      date: date ?? this.date,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'myid': myid,
      'date': date,
      'category': category,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      myid: map['myid'] ?? '',
      date: map['date'] ?? '',
      category: map['category'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        myid,
        date,
        category,
        isDone,
        isDeleted,
        isFavorite,
      ];
}
