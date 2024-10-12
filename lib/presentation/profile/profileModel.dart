class UserProfile {
  final CustomerData customerData;

  UserProfile({required this.customerData});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      customerData: CustomerData.fromJson(json['customer_data']),
    );
  }
}

class CustomerData {
  final int id;
  final User user;
  final InterestStatus? interestStatus;
  final Religion religion;
  final Caste caste;
  final Country country;
  final StateData state;
  final City city;

  final String phone;
  final String gender;
  final String profileCreationFor;
  final String dob;
  final String customerUid;

  CustomerData({
    required this.id,
    required this.user,
    required this.interestStatus,
    required this.religion,
    required this.caste,
    required this.country,
    required this.state,
    required this.city,
    required this.phone,
    required this.gender,
    required this.profileCreationFor,
    required this.dob,
    required this.customerUid,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'],
      user: User.fromJson(json['user']),
      interestStatus:
          json['interest_status'] != null && json['interest_status'].isNotEmpty
              ? InterestStatus.fromMap(json['interest_status'])
              : null,
      religion: Religion.fromJson(json['religion']),
      caste: Caste.fromJson(json['caste']),
      country: Country.fromJson(json['country']),
      state: StateData.fromJson(json['state']),
      city: City.fromJson(json['city']),
      phone: json['phone'],
      gender: json['gender'],
      profileCreationFor: json['profile_creation_for'],
      dob: json['dob'],
      customerUid: json['customer_uid'],
    );
  }
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
    );
  }
}

class Religion {
  final int id;
  final String title;

  Religion({required this.id, required this.title});

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Caste {
  final int id;
  final String title;

  Caste({required this.id, required this.title});

  factory Caste.fromJson(Map<String, dynamic> json) {
    return Caste(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Country {
  final int id;
  final String name;
  final String countryCode;

  Country({
    required this.id,
    required this.name,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      countryCode: json['country_code'],
    );
  }
}

class StateData {
  final int id;
  final String name;

  StateData({
    required this.id,
    required this.name,
  });

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'],
      name: json['name'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
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
