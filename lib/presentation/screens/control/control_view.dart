import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/language_manager.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Scaffold(
            body: cubit.nextPage[cubit.currentIndex],
            bottomNavigationBar: bottomNavigationBar(context));
      },
      listener: (context, state) {},
    );
  }

  Widget bottomNavigationBar(context) => Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 10,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: BottomNavigationBar(
          currentIndex: GlobalCubit.get(context).currentIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedFontSize: 0,
          onTap: (index) {
            GlobalCubit.get(context).changePage(index: index);
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.green,
                  )
                ],
              ),
              label: '',
              icon: Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              label: '',
              icon: Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              label: '',
              icon: Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              label: '',
              icon: Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
            ),
          ],
        ),
  );
}
