import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chit_chat/constand/string.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final String token = await sendFormData(event.username, event.password);
      emit(AuthSuccess(token: token));
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      emit(AuthSuccess(token: token));
    } else {
      emit(AuthNotAuthenticated());
    }
  }

  Future sendFormData(String username, String password) async {
    final url = Uri.parse('${basweUrl}token/');

    var formData = {
      'username': username,
      'password': password,
    };
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final response = await http.post(
      url,
      headers: headers,
      body: formData,
    );

    try {
      if (response.statusCode == 200) {
        print('Login successful');
        var data = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data["access"]);
        await prefs.setInt('user_id', data["customer_id"]);
        return data["access"];
      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

// MuhammedAmjadAli
// User@123