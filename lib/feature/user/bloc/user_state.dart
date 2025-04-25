import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/core/enums/user_type.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSelecting extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSelected extends UserState {
  final UserType userType;

  UserSelected(this.userType);

  @override
  List<Object?> get props => [userType];
}