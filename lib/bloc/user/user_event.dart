part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SetUSer extends UserEvent {
  final User user;
  SetUSer(this.user);
}
