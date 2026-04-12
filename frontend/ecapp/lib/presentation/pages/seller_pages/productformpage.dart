import 'dart:io';

import 'package:ecapp/data/models/newproduct.dart';
import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/newproductbloc.dart';
import 'package:ecapp/presentation/bloc/events/imagepickerevent.dart';
import 'package:ecapp/presentation/bloc/events/newproductevent.dart';
import 'package:ecapp/presentation/bloc/state/imagestate.dart';
import 'package:ecapp/presentation/bloc/state/newproductstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget buildInputCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6),
      ],
    ),
    child: child,
  );
}

class Productformpage extends StatefulWidget {
  const Productformpage({super.key});

  @override
  State<Productformpage> createState() => _ProductformpageState();
}

class _ProductformpageState extends State<Productformpage> {
  final Set<int> selectedIndexes = {};
  final List<String> category = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController(text: '10');
  @override
  Widget build(BuildContext context) {
    final categories = ["Electronics", "Mobile", "Accessories", "Fashion"];
    final dh = MediaQuery.of(context).size.height;

    //final dw = MediaQuery.of(context).size.width;
    return BlocListener<Newproductbloc, Newproductstate>(
      listener: (context, state) {
        if (state is NewproductstateFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is NewproductstateSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Product added")));
        }
      },
      child: BlocBuilder<Newproductbloc, Newproductstate>(
        builder: (context, state) {
          if (state is NewproductstatePending) {
            return Scaffold(body: CircularProgressIndicator());
          }

          if (state is NewproductstateFailed) {
            if (state.message == 'logout') {
              context.pushReplacementNamed("loginpage");
            }
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FB),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: dh * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    buildInputCard(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Product Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    buildInputCard(
                      child: TextField(
                        controller: priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$'),
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: "Price",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(categories.length, (index) {
                        final isSelected = selectedIndexes.contains(index);

                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              setState(() {
                                selectedIndexes.remove(index);
                                category.remove(categories[index]);
                              });
                            } else {
                              setState(() {
                                selectedIndexes.add(index);
                                category.add(categories[index]);
                              });
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.blue),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: Colors.blue.withValues(alpha: 0.3),
                                    blurRadius: 6,
                                  ),
                              ],
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Stock quantity",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildInputCard(
                      child: TextField(
                        controller: stockController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: "Units in stock (default 10)",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Images",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    BlocBuilder<Imagepickerbloc, ImageState>(
                      builder: (context, state) {
                        List<File> images = [];
                        if (state is ImagestateSuccess) {
                          images = List.from(state.Images);
                        }

                        return GestureDetector(
                          onTap: () {
                            if (images.length > 4) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Cannot add more Images"),
                                ),
                              );
                            } else {
                              context.read<Imagepickerbloc>().add(
                                Imagepickerevent(),
                              );
                            }
                          },
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue),
                              color: Colors.blue.withValues(alpha: 0.05),
                            ),
                            child: Center(
                              child: Icon(Icons.add_a_photo, size: 30),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    BlocBuilder<Imagepickerbloc, ImageState>(
                      builder: (context, state) {
                        List<File> images = [];
                        if (state is ImagestateSuccess) {
                          images = List.from(state.Images);
                        }

                        return SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    images[index],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(state is ImagestateSuccess){
                                          state.Images.removeAt(index);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration:  BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle
                                      ),
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.close, color: Colors.white, size: 14,),
                                    ),
                                  ))
                                ]
                              );
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          List<File> imagesList;
                          if (nameController.text.isEmpty ||
                              priceController.text.isEmpty) {
                            return;
                          }

                          final imageState =
                              context.read<Imagepickerbloc>().state;

                          if (imageState is ImagestateSuccess) {
                            imagesList = imageState.Images;
                            final parsedStock =
                                int.tryParse(stockController.text.trim());
                            final stockQty = parsedStock != null && parsedStock >= 0
                                ? parsedStock
                                : 10;
                            final NewProduct product = NewProduct(
                              name: nameController.text.trim().toLowerCase(),
                              price: priceController.text.trim(),
                              category: category,
                              inStock: stockQty,
                              images: imagesList,
                            );
                            context.read<Newproductbloc>().add(
                              Newproductaddrequest(product),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Cannot add product")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
