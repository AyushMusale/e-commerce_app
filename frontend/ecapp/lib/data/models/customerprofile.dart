class CustomerProfile {
  String firstName;
  String lastName;
  String email;
  String address;
  String city;
  String pincode;
  String phoneNo;

  CustomerProfile({
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.email,
    required this.address,
    required this.city,
    required this.pincode,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      firstName: json['profile']['first_name'],
      lastName: json['profile']['last_name'],
      phoneNo: json['profile']['phone_no'].toString(),
      email: json['profile']['email'],
      address: json['profile']['address'],
      city: json['profile']['city'],
      pincode: json['profile']['pincode'].toString(),
    );
  }
}
