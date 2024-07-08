import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/cart-model.dart';
import 'order-successfull-screen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cartModel, child) {
        print("Cart items: ${cartModel.cartItems.length}");
        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.teal,
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: cartModel.cartItems.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: cartModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartModel.cartItems[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item['item'][2],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['item'][0],
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$${item['item'][1]}',
                                    style: TextStyle(fontSize: 16, color: Colors.teal),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () {
                                    if (item['quantity'] > 1) {
                                      cartModel.updateQuantity(index, item['quantity'] - 1);
                                    } else {
                                      cartModel.removeFromCart(index);
                                    }
                                  },
                                ),
                                Text('${item['quantity']}', style: TextStyle(fontSize: 18)),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () {
                                    cartModel.updateQuantity(index, item['quantity'] + 1);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (cartModel.cartItems.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          Text(
                            '\$${cartModel.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderSuccessfulScreen()),
                          );
                          cartModel.clearCart();
                        },
                        style: ElevatedButton.styleFrom(

                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text(
                          'Confirm Order',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}