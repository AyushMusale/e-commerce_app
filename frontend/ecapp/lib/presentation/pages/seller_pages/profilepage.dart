import 'package:ecapp/data/models/sellerprofile.dart';
import 'package:ecapp/presentation/bloc/bloc/sellerprofile.dart';
import 'package:ecapp/presentation/bloc/events/sellerprofileevent.dart';
import 'package:ecapp/presentation/bloc/state/profilestate.dart';
import 'package:ecapp/presentation/widgets/shadowcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerProfilepage extends StatefulWidget {
  const SellerProfilepage({super.key});

  @override
  State<SellerProfilepage> createState() => _SellerProfilepageState();
}

class _SellerProfilepageState extends State<SellerProfilepage> {
  final shopNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SellerPRofileBloc>().add(SellerProfileGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerPRofileBloc, SellerProfilestate>(
      listener: (context, state) {
        if (state is SellerProfileLoadedState) {
          shopNameController.text = state.sellerProfile.shopName;
          ownerNameController.text = state.sellerProfile.ownerName;
          phoneNoController.text = state.sellerProfile.phone;
          emailController.text = state.sellerProfile.email;
          addressController.text = state.sellerProfile.address;
          cityController.text = state.sellerProfile.city;
          pincodeController.text = state.sellerProfile.pincode;
        }
        if (state is SellerProfileFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is SellerProfileSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is SellerProfilePendingState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Basiic Details:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  ShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      child: TextField(
                        controller: shopNameController,
                        decoration: InputDecoration(
                          labelText: "Shop Name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      child: TextField(
                        controller: ownerNameController,
                        decoration: InputDecoration(
                          labelText: "Owner's Name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contact Details:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  ShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: phoneNoController,
                        decoration: InputDecoration(
                          labelText: "Phone no.",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Location:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  ShadowContainer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      child: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Shop Address",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ShadowContainer(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              5.0,
                              2.0,
                              5.0,
                              2.0,
                            ),
                            child: TextField(
                              controller: cityController,
                              decoration: InputDecoration(
                                labelText: "City",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ShadowContainer(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              5.0,
                              2.0,
                              5.0,
                              2.0,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: pincodeController,
                              decoration: InputDecoration(
                                labelText: "Pin Code",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          SellerProfileModel sellerProfile = SellerProfileModel(
                            shopName: shopNameController.text.trim(),
                            ownerName: ownerNameController.text.trim(),
                            phoneNo: phoneNoController.text.trim(),
                            email: emailController.text.trim(),
                            shopAddress: addressController.text.trim(),
                            city: cityController.text.trim(),
                            pincode: pincodeController.text.trim(),
                          );
                      
                          context.read<SellerPRofileBloc>().add(
                            SellerCreateProfileEvent(
                              sellerProfile: sellerProfile,
                            ),
                          );
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
