import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  static const String _cartKey = 'cart_items';
  @override
  Set<Product> build() {
    _loadCart();
    return {};
  }

  void addProduct(Product product) async {
    if (!state.contains(product)) {
      state = {...state, product};
      await _saveCart();
    }
  }

  void removeProduct(Product product) async {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
      await _saveCart();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = state.map((product) => product.toJson()).toList();
    prefs.setString(_cartKey, jsonEncode(cartItems));
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);

    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      final loadedCart =
          decoded.map<Product>((json) => Product.fromJson(json)).toSet();
      state = loadedCart;
    }
  }
}

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}
