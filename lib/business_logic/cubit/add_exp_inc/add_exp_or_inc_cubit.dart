import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exp_or_inc_state.dart';

class AddExpOrIncCubit extends Cubit<AddExpOrIncState> {
  AddExpOrIncCubit() : super(AddExpOrIncInitial());
}
