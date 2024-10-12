part of 'fav_bloc.dart';

@immutable
sealed class FavEvent {}

class FetchAllMatches extends FavEvent {}

class FetchSuggestedPosts extends FavEvent {}
