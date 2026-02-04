class Account {
  final int id;
  final String email;

  Account({required this.id, required this.email});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      email: json['email'] as String
    );
  }
}