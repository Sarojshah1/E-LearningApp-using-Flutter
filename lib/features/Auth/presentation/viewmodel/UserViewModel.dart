import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/domain/usecase/userUseCase.dart';

import '../../domain/Entity/UserEntity.dart';
import '../state/userState.dart';

final authViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
      (ref) => UserViewModel(
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
          (user) => state = UserState(isLoading: false,user: user),
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

  Future<bool> updateUserDetails(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    final result = await userUseCase.updateUserDetails(user);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        return false;
      },
          (success) {
        state = state.copyWith(isLoading: false,error: null);
        return true;
      },
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
  Future<void> userLogin (String email,String password)async{
    print("Starting login");
    state=state.copyWith(isLoading: true,error: null);
    print("State after start: $state");
    final result =await userUseCase.userLogin(email, password);
    result.fold((failure){
      print("Login failed: ${failure.error}");
      state = state.copyWith(isLoading: false, error: failure.error);

    }, (success){
      print("Login successful");
      state = state.copyWith(isLoading: false, error: null);
    });
    print("State after login: $state");

  }


  Future<void> sendOtp(String email)async{
    state=state.copyWith(isLoading: true,error: null);
    final result=await userUseCase.sendOtp(email);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error), (message)=>state=state.copyWith(isLoading: false,message: message));

  }

  Future<void> verifyOtp(String email,String otp)async{
    state=state.copyWith(isLoading: true,error: null);
    final result=await userUseCase.verifyOtp(otp, email);
    print(result);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error), (message)=>state=state.copyWith(isLoading: false,message: message));

  }
  Future<void> ForgetPassword(String email,String password)async{
    state=state.copyWith(isLoading: true,error: null);
    final result=await userUseCase.ForgetPassword(password, email);
    print(result);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error), (message)=>state=state.copyWith(isLoading: false,message: message));

  }

}