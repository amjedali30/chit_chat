abstract class HomeEvent {}

class FetchAllMatches extends HomeEvent {}

class FetchSuggestedPosts extends HomeEvent {}

// class IntreastLoading extends HomeEvent {}

class Sendintrest extends HomeEvent {
  final int recieverId;

  Sendintrest({required this.recieverId});
}

class acceptIntrest extends HomeEvent {
  final int userId;

  acceptIntrest({required this.userId});
}

class declineIntrest extends HomeEvent {
  final int userId;

  declineIntrest({required this.userId});
}

class SendIntrestSuccess extends HomeEvent {}
