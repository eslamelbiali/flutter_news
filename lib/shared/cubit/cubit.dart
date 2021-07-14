import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/modules/business/business_screen.dart';
import 'package:flutter_news/modules/science/science_screen.dart';
import 'package:flutter_news/modules/settings/settings_screen.dart';
import 'package:flutter_news/modules/sports/sports_screen.dart';
import 'package:flutter_news/network/remote/dio_helper.dart';
import 'package:flutter_news/shared/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
     icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
     icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
     icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
     icon: Icon(Icons.settings),
      label: 'Settings',
    ),


  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index==1)
      getSports();
    if(index ==2 )
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'60cca4766c234ed9b6b2b93e09f43f3f',
      },
    ).then((value)
    {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsSportsLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'60cca4766c234ed9b6b2b93e09f43f3f',
        },
      ).then((value)
      {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'eg',
          'category': 'science',
          'apiKey': '60cca4766c234ed9b6b2b93e09f43f3f',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {

    emit(NewsSearchLoadingState());
    search=[];

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q': 'science',
        'apiKey': '60cca4766c234ed9b6b2b93e09f43f3f',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}