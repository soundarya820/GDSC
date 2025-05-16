import 'package:flutter/material.dart';
import 'billing_page.dart';

class CakeDetailsPage extends StatefulWidget {
  final String cakeName;
  final String cakeImage;

  const CakeDetailsPage({
    super.key,
    required this.cakeName,
    required this.cakeImage,
  });

  @override
  State<CakeDetailsPage> createState() => _CakeDetailsPageState();
}

class _CakeDetailsPageState extends State<CakeDetailsPage> {
  final List<Map<String, dynamic>> cart = [];

  final List<Map<String, dynamic>> cakeVariants = [
    {
      'name': 'Chocolate Fudge',
      'image': 'assets/images/chocolate_1.jpg',
      'flavor': 'Chocolate',
      'weight': '0.5 kg',
      'price': 450,
    },
    {
      'name': 'Vanilla Delight',
      'image': 'assets/images/chocolate_2.jpg',
      'flavor': 'Vanilla',
      'weight': '1 kg',
      'price': 800,
    },
    {
      'name': 'Strawberry Dream',
      'image': 'assets/images/chocolate_3.jpg',
      'flavor': 'Strawberry',
      'weight': '0.5 kg',
      'price': 500,
    },
    {
      'name': 'Black Forest Gateau',
      'image': 'assets/images/chocolate_4.jpg',
      'flavor': 'Black Forest',
      'weight': '1 kg',
      'price': 900,
    },
    {
      'name': 'Pineapple Upside Down',
      'image': 'assets/images/chocolate_5.jpg',
      'flavor': 'Pineapple',
      'weight': '0.75 kg',
      'price': 600,
    },
    {
      'name': 'Red Velvet Classic',
      'image': 'assets/images/chocolate_6.jpg',
      'flavor': 'Red Velvet',
      'weight': '0.5 kg',
      'price': 550,
    },
  ];

  void addToCart(int index, int quantity) {
    if (index >= 0 && index < cakeVariants.length) {
      final variant = cakeVariants[index];
      final itemName = variant['name'];
      final price = variant['price'] as int;
      final flavor = variant['flavor'];

      final existing = cart.indexWhere((item) => item['name'] == itemName);
      setState(() {
        if (existing >= 0) {
          cart[existing]['quantity'] += quantity;
        } else {
          cart.add({
            'name': itemName,
            'quantity': quantity,
            'price': price,
            'flavor': flavor,
            'category': widget.cakeName,
          });
        }
      });
    }
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cakeVariants.length) {
      final variant = cakeVariants[index];
      final itemName = variant['name'];
      final existing = cart.indexWhere((item) => item['name'] == itemName);
      if (existing >= 0) {
        setState(() {
          cart.removeAt(existing);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('${widget.cakeName} Cakes'),
        backgroundColor: Colors.pink[200],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cakeVariants.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          final cake = cakeVariants[index];
          int quantity = 1;

          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        cake['image'],
                        height: 170,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '₹${cake['price']} | ${cake['weight']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[900],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Flavor: ${cake['flavor']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() => quantity++);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  addToCart(index, quantity);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Add"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  removeFromCart(index);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Remove"),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: cart.isNotEmpty
          ? BottomAppBar(
        elevation: 8,
        color: Colors.pink[100],
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.pink),
                  const SizedBox(width: 8),
                  Text(
                    '${cart.length} item(s)',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '₹${cart.fold<int>(0, (total, item) => total + (item['price'] as int) * (item['quantity'] as int))}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BillingPage(cartItems: cart),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Proceed'),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
          : null,
    );
  }
}