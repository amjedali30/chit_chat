class UserDetails {
  final int id;
  final User userData;
  final InterestStatus? interest_status;

  UserDetails({
    required this.id,
    required this.userData,
    required this.interest_status,
  });

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'] as int,
      userData: User.fromMap(map['user']),
      interest_status:
          map['interest_status'] != null && map['interest_status'].isNotEmpty
              ? InterestStatus.fromMap(map['interest_status'])
              : null,
    );
  }
}

class User {
  final int id;
  final String username;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.phone,
  });

  // The fromMap method
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
      phone: map['phone'] as String,
    );
  }
}

class InterestStatus {
  int id;
  String interestStatus;
  String createdDate;
  String createdTime;
  String modifiedDate;
  String modifiedTime;
  bool flag;
  int sender;
  int receiver;

  InterestStatus({
    required this.id,
    required this.interestStatus,
    required this.createdDate,
    required this.createdTime,
    required this.modifiedDate,
    required this.modifiedTime,
    required this.flag,
    required this.sender,
    required this.receiver,
  });

  factory InterestStatus.fromMap(Map<String, dynamic> map) {
    return InterestStatus(
      id: map['id'] as int,
      interestStatus: map['interest_status'] as String,
      createdDate: map['created_date'] as String,
      createdTime: map['created_time'] as String,
      modifiedDate: map['modified_date'] as String,
      modifiedTime: map['modified_time'] as String,
      flag: map['flag'] as bool,
      sender: map['sender'] as int,
      receiver: map['reciever'] as int,
    );
  }
}
