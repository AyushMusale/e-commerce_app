import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/bankdetails.dart';
import 'package:ecapp/domain/usecases/bankdetailsusecase.dart';
import 'package:ecapp/presentation/bloc/events/bankfdetailsevent.dart';
import 'package:ecapp/presentation/bloc/state/bankdetailsstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bankdetailsbloc extends Bloc<Bankdetailsevent, Bankdetailsstate> {
  SellerBankdetailsusecase sellerBankdetailsusecase;
  Bankdetailsbloc({required this.sellerBankdetailsusecase})
    : super(BankdetailsInitialState()) {
    on<StoreBankDetailsEvent>((event, emit) async {
      emit(
        Bankdetailsstate(isLoading: true, isError: false, message: 'loading'),
      );
      try {
        Bankdetails bankdetails = Bankdetails(
          accountholderName: event.accholderName,
          accountNummber: event.accountNumber,
          ifsc: event.ifsc,
        );
        final res = await sellerBankdetailsusecase.storeDetails(bankdetails);
        if (res == 'success') {
          emit(
            Bankdetailsstate(
              isLoading: false,
              isError: false,
              message: 'Details stored',
            ),
          );
        }
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            Bankdetailsstate(
              isLoading: false,
              isError: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(Bankdetailsstate(isLoading: false, isError: true, message: ''));
        }
      }
    });

    on<GetDetailsEvent>((event, emit) async {
      emit(
        Bankdetailsstate(isLoading: true, isError: false, message: 'loading'),
      );
      try {
        final res = await sellerBankdetailsusecase.getDetails();
        emit(
          Bankdetailsstate(
            bankdetails: res,
            isLoading: false,
            isError: false,
            message: 'Bank Details',
          ),
        );
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            Bankdetailsstate(
              isLoading: false,
              isError: true,
              message: 'unauthenticated',
            ),
          );
        }
        else if(e is NoDataException){
          emit(Bankdetailsstate(isLoading: false, isError: false, message: 'no data'));
        } 
        else {
          emit(Bankdetailsstate(isLoading: false, isError: true, message: e.toString()));
        }
      }
    });
  }
}
