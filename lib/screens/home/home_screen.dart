import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: cartProducts.isEmpty && allProducts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: allProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  final isInCart = cartProducts.contains(product);

                  return Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.blueGrey.withOpacity(0.05),
                    child: Column(
                      children: [
                        Image.asset(
                          product.image,
                          height: 60,
                          width: 60,
                        ),
                        Text(product.title),
                        Text('Rs ${product.price}'),
                        TextButton(
                          onPressed: () {
                            if (isInCart) {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .removeProduct(product);
                            } else {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .addProduct(product);
                            }
                          },
                          child: Text(isInCart ? 'Remove' : 'Add to cart'),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
