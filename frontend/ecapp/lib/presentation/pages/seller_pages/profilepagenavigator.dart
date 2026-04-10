import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/pages/seller_pages/bankdetails.dart';
import 'package:ecapp/presentation/pages/seller_pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SellerProfilepagenavigator extends StatefulWidget {
  const SellerProfilepagenavigator({super.key});

  @override
  State<SellerProfilepagenavigator> createState() =>
      _SellerProfilepagenavigatorState();
}

class _SellerProfilepagenavigatorState
    extends State<SellerProfilepagenavigator> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final pages = [SellerProfilepage(), SellerBankDetailsPage()];
    final pagesName = ['Personal Details', 'Bank Details'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<Authbloc>().add(LogoutEvent());
              },
              icon: Icon(Icons.logout),
            ),
          ],
      ),
      body: SizedBox(
        width: dw,
        child: Column(
          children: [
            Row(
              children: List.generate(pages.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color:
                          selectedIndex == index
                              ? Colors.blue
                              : const Color.fromARGB(255, 204, 232, 255),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(pagesName[index]),
                  ),
                );
              }),
            ),
            Expanded(child: pages[selectedIndex]),
          ],
        ),
      ),
    );
  }
}
