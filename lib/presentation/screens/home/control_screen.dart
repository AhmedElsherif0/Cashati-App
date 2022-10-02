import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../views/bottom_navBar_widget.dart';


class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Scaffold(
          body: cubit.nextPage[cubit.currentIndex],
          bottomNavigationBar: BottomNavBarWidget(
            cubit: cubit,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
