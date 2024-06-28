import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monex/packages/category.dart';
import 'package:monex/packages/src/expense_repo.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final ExpenseRepository expenseRepository;

  CreateCategoryBloc(this.expenseRepository) : super(CreateCategoryInitial()) {
    on<CreateCategory>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        await expenseRepository.createCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        print('Error: $e');
        emit(CreateCategoryFailure());
      }
    });
  }
}
