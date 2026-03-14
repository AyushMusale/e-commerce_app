import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/events/imagepickerevent.dart';
import 'package:ecapp/presentation/bloc/state/imagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecapp/presentation/widgets/radiobutton.dart';
import 'package:ecapp/presentation/widgets/shadowcontainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Add a new product",
                  style: TextStyle(
                    fontSize: dh * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: dh * 0.02),
                ShadowContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: dh * 0.01),
                ShadowContainer(
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Price",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: dh * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category", style: TextStyle(fontSize: dh * 0.03, fontWeight: FontWeight.bold, color: Colors.black)),
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
                                        : const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: 2,
                                    //offset: Offset(2, 2)
                                  )
                                ]
                              ),
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
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
                        Text(
                          "Product in Stock? ",
                          style: TextStyle(fontSize: dh * 0.025, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
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
                    SizedBox(height: dh * 0.02),
                    Text("Add Images: ", style: TextStyle(fontSize: dh * 0.02)),
                    SizedBox(height: dh * 0.005),
                    BlocBuilder<Imagepickerbloc, ImageState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context.read<Imagepickerbloc>().add(
                              Imagepickerevent(),
                            );
                          },
                          child: Container(
                            height: dh * 0.15,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(150, 165, 198, 255),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Container(
                                height: dh * 0.06,
                                width: dh * 0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: dh * 0.02),
                    Text(
                      "Preview Images: ",
                      style: TextStyle(fontSize: dh * 0.02),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
