import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/enums/user_type.dart';
import 'package:products_store_bloc/feature/user/bloc/user_event.dart';
import 'package:products_store_bloc/feature/user/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc() : super(UserInitial()) {
    on<SelectUser>(_onSelectUser);
    on<LoadPersistedUser>(_onLoadPersistedUser);
  }

  _onSelectUser(SelectUser event, Emitter<UserState> emit) async {
    emit(UserSelecting());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_user', event.userType.label);

    emit(UserSelected(event.userType));
  }

  Future<void> _onLoadPersistedUser(LoadPersistedUser event, Emitter<UserState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selected_user');

    if (saved != null) {
      final type = UserType.values.firstWhere((e) => e.label == saved);
      emit(UserSelected(type));
    }
  }
}