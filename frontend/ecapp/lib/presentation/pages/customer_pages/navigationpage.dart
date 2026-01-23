import 'package:ecapp/presentation/pages/customer_pages/homepage.dart';
import 'package:flutter/material.dart';

class CustomerNavigationpage extends StatefulWidget {
  const CustomerNavigationpage({super.key});

  @override
  State<CustomerNavigationpage> createState() => _CustomerNavigationpageState();
}

class _CustomerNavigationpageState extends State<CustomerNavigationpage> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> pages = [CustomerHomepage()];
    int currrentindex = 0;
    return Scaffold(
      body: pages[currrentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currrentindex,
        onTap: (index){
          setState(()=> currrentindex = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: 'Cart'),
        ],
      ),
    );
  }
}
