import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Productpage extends StatefulWidget {
  final String id;
  const Productpage({super.key, required this.id});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: dh * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 199, 59),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      offset: Offset(3, 3),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text('image'),
              ),
              SizedBox(height: 20),
              Container(
                height: dh * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 33, 65, 243),
                      offset: Offset(3, 3),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("name"),
                    Text("prce"),
                    Text("instock"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Container(
                  height: dh * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.orange, spreadRadius: 2)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Add to cart', style:TextStyle(fontSize: 20),),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.shopping_cart)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
