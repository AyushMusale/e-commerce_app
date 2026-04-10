import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerprofilebloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/events/customerprofileevent.dart';
import 'package:ecapp/presentation/bloc/state/customerprofilestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Customerprofilepage extends StatefulWidget {
  const Customerprofilepage({super.key});

  @override
  State<Customerprofilepage> createState() => _CustomerprofilepageState();
}

class _CustomerprofilepageState extends State<Customerprofilepage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void initState() {
    context.read<CustomerProfileBLoc>().add(GetCustomerProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<Authbloc>().add(LogoutEvent());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: dw * 0.05,
          vertical: dh * 0.02,
        ),
        child: BlocConsumer<CustomerProfileBLoc, CustomerProfileState>(
          listener: (context, state) {
            if (state.isError == true && state.message == 'unauthenticated') {
              context.pushReplacementNamed('loginpage');
            }
            if (state.isError == false && state.message == 'no data') {}
            if (state.isError == true) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state.isError == false && state.initialized) {
              var profile = state.customerProfile;
              firstNameController.text = profile?.firstName ?? '';
              lastNameController.text = profile?.lastName ?? '';
              emailController.text = profile?.email ?? '';
              addressController.text = profile?.address ?? '';
              cityController.text = profile?.city ?? '';
              pincodeController.text = profile?.pincode ?? '';
              phoneController.text = profile?.phoneNo ?? '';
            }
          },
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: dh * 0.03),
                _buildField("First Name", firstNameController, dh),
                _buildField("Last Name", lastNameController, dh),
                _buildField(
                  "Email",
                  emailController,
                  dh,
                  keyboard: TextInputType.emailAddress,
                ),
                _buildField(
                  "Phone Number",
                  phoneController,
                  dh,
                  keyboard: TextInputType.phone,
                ),

                _buildField("Address", addressController, dh, maxLines: 2),
                _buildField("City", cityController, dh),
                _buildField(
                  "Pincode",
                  pincodeController,
                  dh,
                  keyboard: TextInputType.number,
                ),

                SizedBox(height: dh * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: dh * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CustomerProfileBLoc>().add(
                        StoreCustomerProfileEvent(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text.trim(),
                          phoneNo: phoneController.text.trim(),
                          email: emailController.text.trim(),
                          address: addressController.text.trim(),
                          city: cityController.text.trim(),
                          pincode: pincodeController.text.trim(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Save Profile",
                      style: TextStyle(
                        fontSize: dh * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    double dh, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: dh * 0.02),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: dh * 0.018,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
