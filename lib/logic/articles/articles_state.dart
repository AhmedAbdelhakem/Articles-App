part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticleImportState extends ArticlesState {}

class LoginSuccessState extends ArticlesState {}

class ArticlesLoadedState extends ArticlesState {}

class ApiImportSportsState extends ArticlesState {}

class ApiImportBusinessState extends ArticlesState {}

class ApiBottomNavigationBarState extends ArticlesState {}

class ApiChangeTasksState extends ArticlesState {}

class LoginFailureState extends ArticlesState {
  String errorMessage;

  LoginFailureState(this.errorMessage);
}