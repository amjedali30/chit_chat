import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constand/string.dart';
import '../profileModel.dart';
import 'package:http/http.dart' as http;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserProfile>(fetchData);
  }

  FutureOr<void> fetchData(
      FetchUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    int userId = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    final url = Uri.parse('${basweUrl}user_profile/?user_id=${event.userId}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token!}',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        UserProfile userProfile = UserProfile.fromJson(data);

        emit(ProfileLoaded(userProfile));
      } else {
        emit(ProfileError("Something error..."));
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      emit(ProfileError("Something error..."));
      throw Exception('Failed to load all matches');
    }
  }
}
