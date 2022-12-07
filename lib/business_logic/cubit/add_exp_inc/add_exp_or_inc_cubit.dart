import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import '../../repository/expenses_repo/expenses_repo.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit(this._expensesRepository) : super(AddExpOrIncInitial());

  final TransactionsRepository _expensesRepository;

  void addExpense({
    required TransactionModel expenseModel,
    required String choseRepeat,
  }) {
    try {
      _expensesRepository.addTransactions(
          expenseModel: expenseModel, choseRepeat: choseRepeat);
      emit(AddExpOrIncSuccess());
    } catch (error) {
      print('${error.toString()}');
      emit(AddExpOrIncError());
    }
  }
}
