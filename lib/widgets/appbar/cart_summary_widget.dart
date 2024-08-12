import 'package:bagit/bloc/cart/cart_bloc.dart';
import 'package:bagit/bloc/cart/cart_state.dart';
import 'package:bagit/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return IconButton(
          icon: Stack(
            children: [
              const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 32,
              ),
              if (state.cartItems.isNotEmpty)
                Positioned(
                  left: 12,
                  bottom: 13,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${state.cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
