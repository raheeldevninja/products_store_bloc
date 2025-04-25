import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/user/bloc/user_event.dart';
import 'package:products_store_bloc/feature/user/bloc/user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc() : super(UserInitial()) {
    on<SelectUser>(_onSelectUser);
  }

  _onSelectUser(SelectUser event, Emitter<UserState> emit) {
    emit(UserSelecting());
    emit(UserSelected(event.userType));
  }

}