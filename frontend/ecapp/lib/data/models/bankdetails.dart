class Bankdetails {
  String accountholderName;
  String accountNummber;
  String ifsc;
  Bankdetails({
    required this.accountholderName,
    required this.accountNummber,
    required this.ifsc,
  });

  factory Bankdetails.fromJson(Map<String, dynamic> json) {
    return Bankdetails(
      accountholderName: json['bank_details']['account_holder_name'],
      accountNummber: json['bank_details']['accoount_last4'],
      ifsc: json['bank_details']['ifsc'],
    );
  }
}
