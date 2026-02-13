import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecapp/presentation/widgets/radiobutton.dart';

class Productformpage extends StatefulWidget {
  const Productformpage({super.key});

  @override
  State<Productformpage> createState() => _ProductformpageState();
}

class _ProductformpageState extends State<Productformpage> {
  final categories = ["Electronics", "Mobile", "Accessories", "Fashion"];
  final Set<int> selectedIndexes = {};
  bool inStock = true;
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    // final dw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: dh * 0.01),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: InputDecoration(
                  label: Text("Price", style: TextStyle(fontWeight: FontWeight.bold),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: dh * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category", style: TextStyle(fontSize: dh * 0.02)),
                  Wrap(
                    spacing: 8,
                    children: List.generate(categories.length, (index) {
                      final isSelected = selectedIndexes.contains(index);

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (isSelected) {
                              setState(() {
                                selectedIndexes.remove(index);
                              });
                            } else {
                              setState(() {
                                selectedIndexes.add(index);
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: dh * 0.02),
                  Row(
                    children: [
                      Text("Product in Stock? ", style: TextStyle(fontSize: dh*0.02),),
                      Row(
                        children: [
                          Radiobutton(
                            ontap: () {
                              setState(() {
                                inStock = true;
                              });
                            },
                            isSelected: inStock,
                            title: "Yes",
                          ),
                          SizedBox(width: dh * 0.02),
                          Radiobutton(
                            ontap: () {
                              setState(() {
                                inStock = false;
                              });
                            },
                            isSelected: !inStock,
                            title: "No",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
