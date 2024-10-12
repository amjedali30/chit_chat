import 'package:chit_chat/presentation/home/home_bloc/home_bloc.dart';

import '../homeModel.dart';

abstract class HomeState {}

class MatchLoading extends HomeState {}

class MatchLoaded extends HomeState {
  final List<UserDetails> matches;

  MatchLoaded({required this.matches});
}

class MatchError extends HomeState {
  final String error;

  MatchError({required this.error});
}
