import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/events/imagepickerevent.dart';
import 'package:ecapp/presentation/bloc/state/imagestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecapp/presentation/widgets/radiobutton.dart';
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
      body: SafeArea(
        child: Center(
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
                TextField(
                  decoration: InputDecoration(
                    label: Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                    label: Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                                        : const Color.fromARGB(
                                          255,
                                          231,
                                          231,
                                          231,
                                        ),
                                borderRadius: BorderRadius.circular(10),
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
                          style: TextStyle(fontSize: dh * 0.02),
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
