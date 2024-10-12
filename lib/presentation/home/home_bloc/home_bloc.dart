import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chit_chat/constand/string.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../homeModel.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(MatchLoading()) {
    on<FetchAllMatches>(fetchAllMatches);
    on<Sendintrest>(createIntrest);
    on<acceptIntrest>(_acceptIntrest);
    on<declineIntrest>(_declineIntrest);
    // on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  FutureOr<void> createIntrest(
      Sendintrest event, Emitter<HomeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    print(token);
    final url = Uri.parse(
        '${basweUrl}create_interest/?receiver_id=${event.recieverId}');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token!}',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(SendIntrestSuccess() as HomeState);
      } else {}
    } catch (e) {}
  }
}

FutureOr<void> _acceptIntrest(
    acceptIntrest event, Emitter<HomeState> emit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');
  print(token);
  final url = Uri.parse(
      '${basweUrl}change_state_request/?state=accepted&sent_user_id=${event.userId}');
  print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${token!}',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      emit(SendIntrestSuccess() as HomeState);
    } else {}
  } catch (e) {}
}

FutureOr<void> _declineIntrest(
    declineIntrest event, Emitter<HomeState> emit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');
  print(token);
  final url = Uri.parse(
      '${basweUrl}change_state_request/?state=rejected&sent_user_id=${event.userId}');
  print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${token!}',
      },
    );
// /api/interest_undo_toggler/68/
    final url2 = Uri.parse('${basweUrl}interest_undo_toggler/${event.userId}/');
    print(url2);

    final response2 = await http.post(
      url2,
      headers: {
        'Authorization': 'Bearer ${token!}',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      emit(SendIntrestSuccess() as HomeState);
    } else {}
  } catch (e) {}
}

Future fetchAllMatches(FetchAllMatches event, Emitter<HomeState> emit) async {
  print("-------");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final url = Uri.parse('${basweUrl}list/matches/all');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${token!}',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List datas = [];
      List<UserDetails> userDetailsList = [];
      for (int i = 0; i < data["data"].length; i++) {
        // print(data["data"][i]["user"]);

        datas.add(data["data"][i]);
        userDetailsList.add(UserDetails.fromMap(data["data"][i]));
        // userDet.add({

        // })
      }

      // print(datas);
      emit(MatchLoaded(matches: userDetailsList));
    } else {
      throw Exception('Failed to load suggested posts');
    }
  } catch (e) {
    throw Exception('Failed to load all matches');
  }
}
