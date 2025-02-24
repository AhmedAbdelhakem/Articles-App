import 'package:articles/logic/articles/articles_cubit.dart';
import 'package:articles/logic/login/login_cubit.dart';
import 'package:articles/logic/signup/signup_cubit.dart';
import 'package:articles/models/myshared.dart';
import 'package:articles/ui/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyShared.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => SignupCubit(),),
        BlocProvider(create: (context) => ArticlesCubit(ArticlesInitial()),),
      ],
      child:MaterialApp(
        title: 'Articles',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
