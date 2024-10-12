part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;

  ProfileLoaded(
    this.userProfile,
  );
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
