import 'dart:async';
import 'package:flutter/material.dart';
import 'cake_details_user.dart'; // Assuming CakeDetailsPage is in this file

class HomePageUser extends StatefulWidget {
  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final List<String> banners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.jpg',
  ];

  int _currentPage = 0;
  late PageController _pageController;
  Timer? _bannerTimer;

  final List<String> categories = [
    'By Flavor',
    'By Type',
    'By Occasion',
    'By Shape/ Design',
    'By Dietary Preference',
  ];

  String selectedCategory = 'By Flavor';

  final Map<String, List<Map<String, String>>> categoryItems = {
    'By Flavor': [
      {'name': 'Chocolate Cake', 'image': 'assets/images/chocolate.jpg'},
      {'name': 'Vanilla Cake', 'image': 'assets/images/vanila.jpg'},
      {'name': 'Strawberry Cake', 'image': 'assets/images/strawberry.jpg'},
      {'name': 'Black Forest Cake', 'image': 'assets/images/blackforest.jpg'},
      {'name': 'Pineapple Cake', 'image': 'assets/images/pineapple.jpg'},
      {'name': 'Coffee Cake', 'image': 'assets/images/coffee.jpg'},
    ],
    'By Type': [
      {'name': 'Cream Cake', 'image': 'assets/images/cream.jpg'},
      {'name': 'Cheesecake', 'image': 'assets/images/cheese.jpg'},
      {'name': 'Ice Cream Cake', 'image': 'assets/images/icecream.jpg'},
      {'name': 'Cupcake', 'image': 'assets/images/cupcake.jpg'},
      {'name': 'Pastries', 'image': 'assets/images/pastries.jpg'},
    ],
    'By Occasion': [
      {'name': 'Birthday Cake', 'image': 'assets/images/bday.jpg'},
      {'name': 'Anniversary Cake', 'image': 'assets/images/anni.jpg'},
      {'name': 'Wedding Cake', 'image': 'assets/images/wed.jpg'},
      {'name': 'Baby Shower Cake', 'image': 'assets/images/baby.jpg'},
    ],
    'By Shape/ Design': [],
    'By Dietary Preference': [],
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _bannerTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pastelBackground = Colors.pink[50];
    final pastelBox = Colors.pink[100];
    final shadow = [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ];

    return Scaffold(
      backgroundColor: pastelBackground,
      appBar: AppBar(
        title: Text("Cake Shop"),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: shadow,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search cakes...',
                  prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ),
          ),

          // Banner Section
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 10),
            child: PageView.builder(
              controller: _pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(banners[index]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: shadow,
                  ),
                );
              },
            ),
          ),

          // Categories Title
          Container(
            margin: EdgeInsets.only(top: 20, left: 16, right: 16),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: pastelBox,
              borderRadius: BorderRadius.circular(12),
              boxShadow: shadow,
            ),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Category Chips
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = category),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pink[300] : pastelBox,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected ? shadow : [],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.pink[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Cakes Grid
          SizedBox(height: 12),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: shadow,
              ),
              child: categoryItems[selectedCategory]!.isEmpty
                  ? Center(child: Text("No items available in this category"))
                  : GridView.builder(
                itemCount: categoryItems[selectedCategory]!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final cake = categoryItems[selectedCategory]![index];
                  return Container(
                    decoration: BoxDecoration(
                      color: pastelBackground,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: shadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              cake['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                cake['name']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CakeDetailsPage( // Removed const here
                                          cakeName: cake['name']!,
                                          cakeImage: cake['image']!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  child: Text("Explore"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: const Center(
        child: Text(
          'Cart is Empty 🛒',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}