import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('16BitStore'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Our Store',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find the best products here!',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Shop Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Featured Products
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard('Product 1', 'assets/product1.jpg', 29.99),
                  _buildProductCard('Product 2', 'assets/product2.jpg', 59.99),
                  _buildProductCard('Product 3', 'assets/product3.jpg', 19.99),
                ],
              ),
            ),
            // Customer Testimonials
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Customer Testimonials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTestimonialCard('John Doe', 'Great products and fast delivery!'),
                  _buildTestimonialCard('Jane Smith', 'Excellent customer service.'),
                  _buildTestimonialCard('Michael Johnson', 'Highly recommend this store.'),
                ],
              ),
            ),
            // Newsletter Signup
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscribe to our Newsletter',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Subscribe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String title, String imagePath, double price) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('\$$price', style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String testimonial) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(testimonial),
        ],
      ),
    );
  }
}
