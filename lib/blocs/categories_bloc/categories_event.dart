part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class AddCategory extends CategoriesEvent {
  final MyCategory category;
  const AddCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends CategoriesEvent {
  final MyCategory category;
  const UpdateCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class DeleteCategory extends CategoriesEvent {
  final MyCategory category;
  const DeleteCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class EditCategory extends CategoriesEvent {
  final MyCategory oldCategory;
  final MyCategory newCategory;
  const EditCategory({
    required this.oldCategory,
    required this.newCategory,
  });

  @override
  List<Object> get props => [
        oldCategory,
        newCategory,
      ];
}
