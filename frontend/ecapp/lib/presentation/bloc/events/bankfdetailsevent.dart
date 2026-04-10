class Bankdetailsevent {}

class StoreBankDetailsEvent extends Bankdetailsevent{
  String accholderName;
  String accountNumber;
  String ifsc;

  StoreBankDetailsEvent({
    required this.accholderName,
    required this.accountNumber,
    required this.ifsc
  });
}

class GetDetailsEvent extends Bankdetailsevent{}
