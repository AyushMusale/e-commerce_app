import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class Authbloc extends Bloc<Authevent, Authstate> {
  final AuthDB authDB;
  final Authusecase _authusecase;
  Authbloc(this._authusecase, this.authDB) : super(AuthstateInitial()) {
    on<AuthLoginevent>((event, emit) async {
      emit(AuthstatePending());
      try {
        final res = await _authusecase.execute(
          email: event.email,
          password: event.password,
        );
        emit(AuthstateSucces(userRole: res.userRole));
      } catch (e) {
        emit(
          AuthstateFailed(
            message: e.toString().replaceFirst('Exception: ', ""),
          ),
        );
      }
    });
    on<AuthChecksession>((event, emit) async {
      final accessToken = authDB.getAccessToken();
      final refreshToken = authDB.getRefreshToken();
      final userRole  = authDB.getUserrole();
      if (accessToken != null && refreshToken != null) {
        emit(AuthstateSucces(userRole: userRole));
      } else {
        emit(AuthstateUnauthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthstatePending());
      try {
        await Hive.box('authDB').clear();
        emit(AuthstateUnauthenticated());
      } catch (e) {
        emit(AuthstateAuthenticated());
      }
    });
  }
}
