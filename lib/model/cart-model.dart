import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    [
      'Sushi',
      '60.00',
      'assets/images/sushi.png',
      Colors.brown,
      'Sushi is a traditional Japanese dish featuring vinegared rice combined with ingredients such as raw or cooked seafood, vegetables, and sometimes tropical fruits. It is often served with soy sauce, wasabi, and pickled ginger and comes in various forms like nigiri (rice topped with fish), maki (rolled sushi), and sashimi (sliced raw fish without rice).'
    ],
    [
      'Ice cream',
      '80.90',
      'assets/images/Ice cream.png',
      Colors.green,
      'A frozen dessert made from dairy products, such as milk and cream, and often combined with fruits, nuts, or other ingredients for flavoring. It comes in various flavors and forms, such as cones, sundaes, and shakes.'
    ],
    [
      'Burger',
      '60.00',
      'assets/images/burger (1).png',
      Colors.yellow,
      'A burger is a sandwich consisting of a cooked patty of ground meat, usually beef, placed inside a sliced bread roll or bun. It is often garnished with toppings such as lettuce, tomato, onion, pickles, cheese, and condiments like ketchup, mustard, and mayonnaise. Burgers can also be made with other ingredients like chicken, turkey, or plant-based alternatives.'
    ],
    [
      'Birthday cakes',
      '80.90',
      'assets/images/birthday cake.png',
      Colors.purple,
      'Creamy vanilla ice cream blended with chunks of chocolate sandwich cookies, offering a delightful mix of textures and flavors.'
    ],
    [
      'Dough nut',
      '60.00',
      'assets/images/donuts2.png',
      Colors.pink,
      'Fried dough pastries that are typically ring-shaped or filled with sweet fillings like jelly, cream, or custard. They are often glazed or dusted with powdered sugar.'
    ],
    [
      'Cup Cake',
      '80.90',
      'assets/images/cup cake.png',
      Colors.blue,
      'Cake is a sweet baked dessert made from a mixture of flour, sugar, eggs, and butter or oil, often leavened with baking powder or baking soda. Cakes can come in various flavors and styles, including chocolate, vanilla, and fruit, and are typically frosted or decorated with icing, cream, or other toppings. They are commonly served on special occasions such as birthdays, weddings, and celebrations.'
    ]
  ];

  get shopItems => _shopItems;

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(int index) {
    final existingIndex =
        _cartItems.indexWhere((item) => item['item'] == _shopItems[index]);
    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity']++;
    } else {
      _cartItems.add({
        'item': _shopItems[index],
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      _cartItems[index]['quantity'] = newQuantity;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0,
        (total, current) =>
            total + (double.parse(current['item'][1]) * current['quantity']));
  }
}
