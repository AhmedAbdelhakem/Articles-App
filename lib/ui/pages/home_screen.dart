import 'package:articles/logic/articles/articles_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_paginator/number_paginator.dart';


class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ArticlesCubit cubit;

  int numberOfPage = 3;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    cubit = ArticlesCubit(ArticlesInitial())..getHttp();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<ArticlesCubit, ArticlesState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = BlocProvider.of<ArticlesCubit>(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/coloredLogo.svg',
                width: 30,
                height: 30,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(0.4),
                    size: 30,
                  ),
                ),
              ],
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.black.withOpacity(0.4),
                  size: 30,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: cubit.screen[cubit.position],
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(4),
              child: NumberPaginator(
                config: NumberPaginatorUIConfig(
                  contentPadding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                  buttonSelectedBackgroundColor: Colors.amber,
                  buttonUnselectedForegroundColor: Colors.grey[400],
                ),
                numberPages: numberOfPage,
                onPageChange: (value) {
                  switch (value) {
                    case 0:
                      {
                        cubit.changeTaskState("TECHNOLOGY NEWS");
                      }
                      break;
                    case 1:
                      {
                        cubit.changeTaskState("SPORTS NEWS");
                      }
                      break;
                    case 2:
                      {
                        cubit.changeTaskState("BUSINESS NEWS");
                      }
                      break;
                  }
                  cubit.onBottomNavigationChange(value);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
