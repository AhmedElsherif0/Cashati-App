import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/screens/user/language_screen.dart';
import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'data/local/cache_helper.dart';
import 'presentation/router/app_router.dart';
import 'presentation/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(MyApp(appRouter: AppRouter()));
   Bloc.observer = MyBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, Key? key}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: LanguageScreen(),
    );

    /*MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // locale: LanguageManager.getAppLanguage(),
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  theme: appTheme,
                );
              });
            },
          );
        },
      ),
    );*/
  }
}
