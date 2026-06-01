class Expense {
  String title;
  double amount;
  String category;
  String date;
  String description;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "amount": amount,
      "category": category,
      "date": date,
      "description": description,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json["title"],
      amount: json["amount"],
      category: json["category"],
      date: json["date"],
      description: json["description"],
    );
  }
}
