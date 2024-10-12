import 'package:chit_chat/presentation/login/authBloc/auth_bloc.dart';
import 'package:chit_chat/presentation/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mainPage/widget/bottomNav.dart';

class Login_Page extends StatelessWidget {
  Login_Page({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            indexChangeNotifer.value = 0;
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Invalied Credential")),
            );
          }
        },
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginButtonPressed(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
