part of 'profile_bloc.dart';

@immutable
class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final int userId;
  FetchUserProfile({required this.userId});
}
