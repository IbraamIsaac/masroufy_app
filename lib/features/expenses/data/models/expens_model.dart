class ExpenseModel {
  final String id;
  final double amount;
  final String category;
  final DateTime date;
  final String? note;
  final String? receiptImagePath;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
    this.receiptImagePath,
  });

// from map to object
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      note: map['note'] as String?,
      receiptImagePath: map['receiptImagePath'] as String?,
    );
  }

// to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'date': date.millisecondsSinceEpoch,
      'note': note,
      'receiptImagePath': receiptImagePath,
    };
  }

  ExpenseModel copyWith({
    String? id,
    double? amount,
    String? category,
    DateTime? date,
    String? note,
    String? receiptImagePath,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      receiptImagePath: receiptImagePath ?? this.receiptImagePath,
    );
  }

  @override
  String toString() {
    return 'ExpenseModel(id: $id, amount: $amount, category: $category, '
        'date: $date, note: $note, receiptImagePath: $receiptImagePath)';
  }
}
