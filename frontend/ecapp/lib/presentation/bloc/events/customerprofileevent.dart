import 'package:ecapp/data/models/customerprofile.dart';

class CustomerProfileEvent {}

class StoreCustomerProfileEvent extends CustomerProfileEvent {
  String firstName;
  String lastName;
  String email;
  String address;
  String city;
  String pincode;
  String phoneNo;

  StoreCustomerProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.email,
    required this.address,
    required this.city,
    required this.pincode,
  });

  CustomerProfile profile() {
    return CustomerProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNo: phoneNo,
      email: email,
      address: address,
      city: city,
      pincode: pincode,
    );
  }
}

class GetCustomerProfileEvent extends CustomerProfileEvent {}
