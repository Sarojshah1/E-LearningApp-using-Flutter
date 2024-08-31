

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';


final AppSharedPrefsProvider = Provider<AppSharedPrefs>((ref) {
  return AppSharedPrefs();
});

class AppSharedPrefs{
  late SharedPreferences _sharedPreferences;
  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<Either<Failure, bool>> setFirstTime(bool time) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool('FirstTime', time);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
  // Get user token
  Future<Either<Failure, bool?>> getFirstTime() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final firstTime = _sharedPreferences.getBool('FirstTime');
      return right(firstTime);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
  Future<Either<Failure, bool>> initializeFirstTime() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      if (!_sharedPreferences.containsKey('FirstTime')) {
        await _sharedPreferences.setBool('FirstTime', true);
      }
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteFirstTime() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('FirstTime');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

}
