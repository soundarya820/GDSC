// billing_page.dart

import 'package:flutter/material.dart';

class BillingPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const BillingPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    cartItems.forEach((item) {
      total += item['quantity'] * item['price'];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Billing & Confirmation"),
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  double itemTotal = item['quantity'] * item['price'];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text('Qty: ${item['quantity']}'),
                        Text('₹${itemTotal.toStringAsFixed(0)}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('₹${total.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order Confirmed! 🎉')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Confirm Order', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
