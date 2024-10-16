class User {
  final String id;
  final String phoneNumber;
  final String name;
  final String picture;
  final int balance;
  final int cashback;

  User({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.picture,
    required this.balance,
    required this.cashback,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'picture': picture,
      'balance': balance,
      'cashback': cashback,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      picture: map['picture'],
      balance: map['balance'],
      cashback: map['cashback'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      picture: json['picture'],
      balance: json['balance'],
      cashback: json['cashback'],
    );
  }
}
