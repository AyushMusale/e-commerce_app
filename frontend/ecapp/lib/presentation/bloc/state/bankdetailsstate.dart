import 'package:ecapp/data/models/bankdetails.dart';

class Bankdetailsstate {
  Bankdetails? bankdetails;
  bool isLoading;
  bool isError;
  String message;

  Bankdetailsstate({
    this.bankdetails,
    required this.isLoading,
    required this.isError,
    required this.message
  });
}

class BankdetailsInitialState extends Bankdetailsstate{
  BankdetailsInitialState():super(isLoading: true,isError: false,message: 'intializing');
}