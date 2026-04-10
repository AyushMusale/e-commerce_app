import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/domain/usecases/searchusecase.dart';
import 'package:ecapp/presentation/bloc/events/searchevent.dart';
import 'package:ecapp/presentation/bloc/state/searchstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Searchbloc extends Bloc<Searchevent, SearchState> {
  final SearchUsecase searchUsecase;

  Searchbloc({required this.searchUsecase}) : super(SearchInititalState()) {
    on<SearchProductEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: false, message: 'loading'));
      try {
        final result = await searchUsecase.execute(event.keyword);
        emit(
          state.copyWith(
            searchlist: result,
            isLoading: false,
            error: false,
            message: 'success',
          ),
        );
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(state.copyWith(isLoading: false, error: true, message: 'unauthenticated'));
        } else if (e is NoDataException) {
          emit(state.copyWith(isLoading: false, error: false, message: 'no data'));
        } else {
          emit(state.copyWith(isLoading: false, error: true, message: e.toString()));
        }
      }
    });
  }
}