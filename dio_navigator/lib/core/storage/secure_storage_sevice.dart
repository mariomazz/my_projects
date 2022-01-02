import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_model/core/storage/secure_storage_configurations.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> getTokenByKey(String secureStorageKey) async {
    try {
      switch (secureStorageKey) {
        case SecureStorageKeys.DATABASE_KEY_ACCESSTOKEN:
          return await _secureStorage.read(
            key: secureStorageKey,
          );
        case SecureStorageKeys.DATABASE_KEY_IDTOKEN:
          return await _secureStorage.read(
            key: secureStorageKey,
          );
        case SecureStorageKeys.DATABASE_KEY_REFRESHTOKEN:
          return await _secureStorage.read(
            key: secureStorageKey,
          );
        case SecureStorageKeys.DATABASE_KEY_EXPIRYDATE:
          return await _secureStorage.read(
            key: secureStorageKey,
          );
        default:
          throw Exception(' (getTokenById) KEY database non valida');
      }
    } catch (e) {
      log('(getTokenById) Errore Lettura dal Database - $e');
      return null;
    }
  }

  Future<void> saveTokensIntoDB(
      {required String accessToken,
      required String refreshToken,
      required String expiryDate,
      required String idToken}) async {
    await clearALLtokensIntoDB();
    await _secureStorage.write(
      key: SecureStorageKeys.DATABASE_KEY_ACCESSTOKEN,
      value: accessToken,
    );
    await _secureStorage.write(
      key: SecureStorageKeys.DATABASE_KEY_REFRESHTOKEN,
      value: refreshToken,
    );
    await _secureStorage.write(
      key: SecureStorageKeys.DATABASE_KEY_IDTOKEN,
      value: idToken,
    );
    await _secureStorage.write(
      key: SecureStorageKeys.DATABASE_KEY_EXPIRYDATE,
      value: expiryDate,
    );
  }

  Future<void> clearALLtokensIntoDB() async {
    await _secureStorage.delete(
        key: SecureStorageKeys.DATABASE_KEY_ACCESSTOKEN);
    await _secureStorage.delete(key: SecureStorageKeys.DATABASE_KEY_EXPIRYDATE);
    await _secureStorage.delete(key: SecureStorageKeys.DATABASE_KEY_IDTOKEN);
    await _secureStorage.delete(
        key: SecureStorageKeys.DATABASE_KEY_REFRESHTOKEN);
  }
}
