
import 'package:ecapp/presentation/bloc/bloc/bankdetails.dart';
import 'package:ecapp/presentation/bloc/events/bankfdetailsevent.dart';
import 'package:ecapp/presentation/bloc/state/bankdetailsstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SellerBankDetailsPage extends StatefulWidget {
  const SellerBankDetailsPage({super.key});

  @override
  State<SellerBankDetailsPage> createState() => _SellerBankDetaildState();
}

class _SellerBankDetaildState extends State<SellerBankDetailsPage> {
  var accNumController = TextEditingController();
  var ifscController = TextEditingController();
  var accholderNameController = TextEditingController();

  @override
  void initState() {
    context.read<Bankdetailsbloc>().add(GetDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<Bankdetailsbloc, Bankdetailsstate>(
          listener: (context, state) {
            if (state.isError == true && state.message == 'unauthenticated') {
              context.pushReplacementNamed('loginpage');
            }
            else if (state.isError == false && state.message == 'no data'){}
            if(state.isError == true){
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state.isError == false) {
              if (state.bankdetails?.accountNummber != null) {
                accNumController.text = state.bankdetails?.accountNummber ?? '';
              }
            }
          },
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your bank details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),
                TextField(
                  controller: accholderNameController,
                  decoration: InputDecoration(
                    labelText: "Account Holder Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                TextField(
                  controller: accNumController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Account Number",
                    hintText: 'xxxx xxxx 1234',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                TextField(
                  controller: ifscController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: "IFSC Code",
                    border: OutlineInputBorder(),
                  ),
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final accHoldername = accholderNameController.text.trim();
                      final accNum = accNumController.text.trim();
                      final ifsc = ifscController.text.trim();
                      context.read<Bankdetailsbloc>().add(
                        StoreBankDetailsEvent(
                          accholderName: accHoldername,
                          accountNumber: accNum,
                          ifsc: ifsc,
                        ),
                      );
                    },
                    child: const Text(
                      "Save & Continue",
                      style: TextStyle(color: Colors.black),
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
}
