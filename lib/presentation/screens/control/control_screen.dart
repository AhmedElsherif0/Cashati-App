import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/language_manager.dart';
import '../../widgets/bottom_nav_bar.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Scaffold(

            body: cubit.nextPage[cubit.currentIndex],
            bottomNavigationBar: BottomNavBarWidget(cubit: cubit,),);
      },
      listener: (context, state) {},
    );
  }


}
