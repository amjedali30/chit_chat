import 'package:chit_chat/presentation/login/authBloc/loginPage.dart';
import 'package:chit_chat/presentation/mainPage/widget/bottomNav.dart';
import 'package:flutter/material.dart';

import '../home/homePage.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _page = [HomePage(), Login_Page()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifer,
        builder: (context, int index, _) {
          return _page[index];
        },
      ),
      bottomNavigationBar: BottomNavWidget(),
    );
  }
}
