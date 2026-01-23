import 'package:ecapp/presentation/pages/seller_pages/homepage.dart';
import 'package:flutter/material.dart';

class SellerNavigationpage extends StatefulWidget {
  const SellerNavigationpage({super.key});

  @override
  State<SellerNavigationpage> createState() => _SellerNavigationpageState();
}

class _SellerNavigationpageState extends State<SellerNavigationpage> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> pages = [SellerHomepage()];
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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: 'Products'),
        ],
      ),
    );
  }
}
