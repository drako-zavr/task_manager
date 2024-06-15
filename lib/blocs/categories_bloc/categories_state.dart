part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final List<MyCategory> allCategories;
  const CategoriesState({
    this.allCategories = const <MyCategory>[],
  });

  @override
  List<Object> get props => [allCategories];
}

// class CategoriesInitial extends CategoriesState {}
