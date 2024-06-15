import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState()) {
    on<CategoriesEvent>((event, emit) {
      on<AddCategory>(_onAddCategory);
      on<UpdateCategory>(_onUpdateCategory);
      on<DeleteCategory>(_onDeleteCategory);
      on<EditCategory>(_onEditCategory);
    });
  }

  void _onAddCategory(AddCategory event, Emitter<CategoriesState> emit) {
    final state = this.state;
    emit(CategoriesState(
      allCategories: List.from(state.allCategories)..add(event.category),
    ));
  }

  void _onUpdateCategory(UpdateCategory event, Emitter<CategoriesState> emit) {
    final state = this.state;
    final category = event.category;
  }

  void _onDeleteCategory(DeleteCategory event, Emitter<CategoriesState> emit) {
    final state = this.state;

    emit(CategoriesState(
      allCategories: List.from(state.allCategories)..remove(event.category),
    ));
  }

  void _onEditCategory(EditCategory event, Emitter<CategoriesState> emit) {}
}
