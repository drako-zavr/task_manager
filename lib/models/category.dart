// import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyCategory extends Equatable {
  final String title;
  final String id;
  final String color;

  MyCategory({
    required this.title,
    required this.id,
    required this.color,
  }) {}

  MyCategory copyWith({
    String? title,
    String? id,
    String? color,
  }) {
    return MyCategory(
      title: title ?? this.title,
      id: id ?? this.id,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'color': color,
    };
  }

  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      color: map['color'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        color,
      ];
}
