import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class GlobalCubit extends Cubit<HomeState> {
  GlobalCubit() : super(HomeInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

}