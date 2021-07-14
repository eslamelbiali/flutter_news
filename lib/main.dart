import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/layout/news_layout.dart';
import 'package:flutter_news/network/remote/dio_helper.dart';
import 'package:flutter_news/shared/cubit/cubit.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()),
      ],
      child: MaterialApp(
        title: 'News App',
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.orange,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              elevation:30.0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: NewsLayout(),
      ),
    );
  }
}