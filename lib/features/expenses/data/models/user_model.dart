class UserModel {
  final String id;
  final double amount;

  UserModel({
    required this.id,
    required this.amount,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
    };
  }

  UserModel copyWith({
    String? id,
    double? amount,
  }) {
    return UserModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, amount: $amount)';
  }
}