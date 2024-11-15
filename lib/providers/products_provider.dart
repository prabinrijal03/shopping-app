import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
part 'products_provider.g.dart';

List<Product> allProducts = [
  Product(
      id: '1',
      title: 'Groovy Shorts',
      price: 1200,
      image: 'assets/products/shorts.png'),
  Product(
      id: '2',
      title: 'Karati Kit',
      price: 3400,
      image: 'assets/products/karati.png'),
  Product(
      id: '3',
      title: 'Denim Jeans',
      price: 5400,
      image: 'assets/products/jeans.png'),
  Product(
      id: '4',
      title: 'Red Backpack',
      price: 4400,
      image: 'assets/products/backpack.png'),
  Product(
      id: '5', title: 'Drum', price: 2000, image: 'assets/products/drum.png'),
  Product(
      id: '6',
      title: 'Skates',
      price: 3000,
      image: 'assets/products/skates.png'),
  Product(
      id: '7',
      title: 'Suitcase',
      price: 3300,
      image: 'assets/products/suitcase.png'),
  Product(
      id: '8',
      title: 'Guitar',
      price: 5500,
      image: 'assets/products/guitar.png'),
];

@riverpod
List<Product> products(ref) {
  return allProducts;
}

@riverpod
List<Product> reducedProducts(ref) {
  return allProducts.where((p) => p.price < 50).toList();
}
