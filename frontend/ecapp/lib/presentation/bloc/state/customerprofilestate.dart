import 'package:ecapp/data/models/customerprofile.dart';

class CustomerProfileState {
  CustomerProfile? customerProfile;
  bool isLoading;
  bool isError;
  String message;
  bool initialized;

  CustomerProfileState({
    this.customerProfile,
    required this.isLoading,
    required this.isError,
    required this.message,
    this.initialized = true,
  });
}

class CustomerProfileInitialState extends CustomerProfileState {
  CustomerProfileInitialState()
    : super(isLoading: false, isError: false, message: 'Initializing', initialized: false);
}
