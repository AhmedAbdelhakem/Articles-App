import 'package:articles/ui/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit([ArticlesInitial? articlesInitial]) : super(ArticlesInitial());
  static ArticlesCubit get (context) => BlocProvider.of(context);

  List<dynamic> articles = [];

  int position = 0;

  var title = [
    'News',
  ];

  List<Widget> screen = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void getHttp() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'technology',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      if (kDebugMode) {
        print("RESPONSE => $response");
      }
      articles = response.data['articles'];
      emit(ArticleImportState());

    } catch (e) {
      if (kDebugMode) {
        print("ERROR => $e");
      }
    }
  }

  void sports() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      print("RESPONSE => $response");
      articles = response.data['articles'];
      emit(ApiImportSportsState());

    } catch (e) {
      print("ERROR => $e");
    }
  }

  void business() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'business',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      print("RESPONSE => $response");
      articles = response.data['articles'];
      emit(ApiImportBusinessState());

    } catch (e) {
      print("ERROR => $e");
    }
  }

  void onBottomNavigationChange(int value) {
    position = value;
    getHttp();
    sports();
    business();
    emit(ApiBottomNavigationBarState());
  }

  String tasksState = "active";

  void changeTaskState(String state){
    tasksState = state;
    getHttp();
    sports();
    business();
    emit(ApiChangeTasksState());
  }

}
