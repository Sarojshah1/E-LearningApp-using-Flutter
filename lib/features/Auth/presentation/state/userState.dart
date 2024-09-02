import '../../data/model/UserModel.dart';
import '../../domain/Entity/UserEntity.dart';

class UserState {
  final bool isLoading;
  final String? error;
  final List<UserEntityModel>? users;
  final UserEntityModel? user;

  UserState({
    required this.isLoading,
    this.error,
    this.users,
    this.user,
  });

  factory UserState.initial() {
    return UserState(
      isLoading: false,
      error: null,
      users: null,
      user: null,
    );
  }

  UserState copyWith({
    bool? isLoading,
    String? error,
    List<UserEntityModel>? users,
    UserEntityModel? user,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users ?? this.users,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'UserState(isLoading: $isLoading, error: $error, users: $users, user: $user)';
  }
}
