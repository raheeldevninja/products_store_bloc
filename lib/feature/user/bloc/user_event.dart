import 'package:equatable/equatable.dart';
import 'package:products_store_bloc/core/enums/user_type.dart';

class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectUser extends UserEvent {
  final UserType userType;

  SelectUser(this.userType);

  @override
  List<Object?> get props => [userType];
}