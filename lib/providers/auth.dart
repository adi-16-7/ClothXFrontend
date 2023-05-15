import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';


class Auth with ChangeNotifier {
  var state;
  int id = 0, newOtp = 0;
  bool status = false;
  DateTime? expiryDate;

  String countryCode = "", mobileNumber = "", token = "";
  bool isNewUser = false;

  extractNewUser() async {
    final secureStorage = new FlutterSecureStorage();
    String? value = await secureStorage.read(key: 'isNewUser');
    return (value == 'true');
  }

  get validateNewUser async {
    if (getToken != null && await extractNewUser()) return true;
    return false;
  }

  String? get getToken {
    // ignore: unnecessary_null_comparison
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != "") {
      return token;
    }
    return null;
  }

  updatePhoneAtuhCreds(statusNew, tokenNew, isNewUserNew, expiryDateNew, cCode) {
    status = statusNew;
    token = tokenNew;
    isNewUser = isNewUser;
    expiryDate = expiryDateNew;
    countryCode = cCode;
    notifyListeners();
  }

  updateNewOtp(otpNew) {
    newOtp = otpNew;
    notifyListeners();
  }

  updatePeopleId(idNew) {
    id = idNew;
    notifyListeners();
  }

  updateMobileCode(countryCodeNew, mobNo) {
    countryCode = countryCodeNew;
    mobileNumber = mobNo;
  }

  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;
  updateStatusTrue() {
    _isDeleted = true;
    notifyListeners();
  }

  updateStatusFalse() {
    _isDeleted = false;
    notifyListeners();
  }
}