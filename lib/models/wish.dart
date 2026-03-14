class Wish {
  final int id;
  final DateTime? createdAt;
  final String title;
  final double? price;
  final String category;
  final String notes;

  Wish({
    required this.id,
    this.createdAt,
    required this.title,
    this.price,
    this.category = '',
    this.notes = '',
  });

  factory Wish.fromMap(Map<String, dynamic> map) {
    return Wish(
      id: map['id'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      title: map['title'] ?? '',
      price: map['price'] != null
          ? (map['price'] as num).toDouble()
          : null,
      category: map['category'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'category': category,
      'notes': notes,
    };
  }
}