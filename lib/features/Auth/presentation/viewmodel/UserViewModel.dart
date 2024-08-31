import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/domain/usecase/userUseCase.dart';

import '../../domain/Entity/UserEntity.dart';
import '../state/userState.dart';

final authViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
      (ref) => UserViewModel(
    // ref.read(loginViewNavigatorProvider),
    ref.read(userUsecaseProvider),
  ),
);

class UserViewModel extends StateNotifier<UserState>{
  final userUsecase userUseCase;

  UserViewModel(this.userUseCase) : super(UserState.initial()) ;
  Future<void> createUser(UserEntity user, File? profilePicture) async {
    state = state.copyWith(isLoading: true);
    final result = await userUseCase.createUser(user, profilePicture);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false,error: failure.error),
          (success) => state = UserState(isLoading: false),
    );
  }

  Future<void> getUsers() async {
    state =  UserState(isLoading: true);
    final result = await userUseCase.getUsers();
    result.fold(
          (failure) => state = UserState(isLoading: false, error: failure.error),
          (users) => state = UserState(isLoading: false,user: users),
    );
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(isLoading: true);
    final result = await userUseCase.changePassword(oldPassword, newPassword);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.error),
          (success) => state = state.copyWith(isLoading: false),
    );
  }

  Future<void> updateUserDetails(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    final result = await userUseCase.updateUserDetails(user);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.error),
          (success) => state = state.copyWith(isLoading: false),
    );
  }

  Future<void> updateProfilePicture(File? profilePicture) async {
    state = state.copyWith(isLoading: true);
    final result = await userUseCase.updateProfilePicture(profilePicture);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.error),
          (success) => state = state.copyWith(isLoading: false),
    );
  }

}