import 'dart:convert';

class Product {
  final String id;
  final String title;
  final int price;
  final String image;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ price.hashCode ^ image.hashCode;
  }
}
