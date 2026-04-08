import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerhomebloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/events/customerhomeevent.dart';
import 'package:ecapp/presentation/bloc/state/customerhomestate.dart';
import 'package:ecapp/presentation/widgets/productlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({super.key});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  @override
  void initState() {
    context.read<Customerhomebloc>().add(GetCustomerDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<Customerhomebloc, Customerhomestate>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CustomerhomeFailurestate) {
                  return Center(child: Text(state.message));
                }
                if (state is CustomerhomePendingstate ||
                    state is CustomerhomeInitialstate) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CustomerhomeSuccessstate) {
                  final List<Product> electronics = state.homedata.electronics;
                  final List<Product> fashion = state.homedata.fashion;
                  return Column(
                    children: [
                      Container(
                        height: dh * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(3),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey,
                          //     spreadRadius: 2,
                          //     offset: Offset(2, 2)
                          //   )
                          // ]
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Text(
                                    "Search",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: dh * 0.3,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 190, 59),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(6, 6),
                              spreadRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 40),
                      ProductHorizontalList(
                        title: "Electronics",
                        products: electronics,
                      ),
                      SizedBox(height: 40),
                      ProductHorizontalList(
                        title: "Fashion",
                        products: fashion,
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ),
      ),
    );
  }
}
