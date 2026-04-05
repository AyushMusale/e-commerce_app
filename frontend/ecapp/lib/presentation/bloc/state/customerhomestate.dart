import 'package:ecapp/data/models/homedata.dart';

class Customerhomestate {}

class CustomerhomeSuccessstate extends Customerhomestate{
  Homedata homedata;
  CustomerhomeSuccessstate({
    required this.homedata
  });
}
class CustomerhomeFailurestate extends Customerhomestate{
  String message;
  CustomerhomeFailurestate({
    required this.message,
  });
}
class CustomerhomePendingstate extends Customerhomestate{}
class CustomerhomeInitialstate extends Customerhomestate{}