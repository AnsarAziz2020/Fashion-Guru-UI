import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';

EmailOTP myAuth = EmailOTP();

Future<void> sendEmailForOTP(String email) async {
  try {
    myAuth.setConfig(
        appEmail: "ansaraziz2016@gmail.com",
        appName: "Fashion Guru ~ Email OTP",
        userEmail: email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);

    var template = 'Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
    myAuth.setTemplate(render: template);
    await myAuth.sendOTP();
  } catch (err) {
    print(err);
  }
}

Future verifyOtp(String email, String code) async {
  print(code);
  try {
    myAuth.setConfig(
        appEmail: "ansaraziz2016@gmail.com",
        appName: "Fashion Guru ~ Email OTP",
        userEmail: email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    print(await myAuth.verifyOTP(otp: code));
    if (await myAuth.verifyOTP(otp: code) == true) {
      print("verified");
    } else {
      print("False");
    }
  } catch (err) {
    print(err);
  }
}
