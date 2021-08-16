part of 'user_bloc.dart';

class UserState {
  final bool existeUsuario;
  final User user;

  UserState({User usuario})
      : user = usuario,
        existeUsuario = (usuario != null) ? true : false;

  copyWith({User user}) => UserState(
        usuario: user ?? this.user,
      );
}

class UserInitial extends UserState {}
