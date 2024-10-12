import 'package:chit_chat/presentation/home/home_bloc/home_bloc.dart';
import 'package:chit_chat/presentation/mainPage/home.dart';
import 'package:chit_chat/presentation/profile/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/login/authBloc/auth_bloc.dart';
import 'presentation/login/authBloc/loginPage.dart';
import 'presentation/home/homePage.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(),
    ),
    BlocProvider(
      create: (context) => HomeBloc(),
    ),
    BlocProvider(
      create: (context) => ProfileBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
