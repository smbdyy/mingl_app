class Account {
  final int id;

  Account({required this.id});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['accountId'] as int,
    );
  }
}