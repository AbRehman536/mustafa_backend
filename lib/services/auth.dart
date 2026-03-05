import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  ///Register User
  Future<User> registerUser({
    required String email,
    required String password
})async{
    try{
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
       userCred.user!.sendEmailVerification();
       return userCred.user!;
    }catch(e){
      throw e.toString();
    }
  }
  ///Login User
  Future<User> loginUser({
    required String email,
    required String password
  })async{
    try{
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCred.user!;
    }catch(e){
      throw e.toString();
    }
  }
  ///Reset Password
  Future resetPassword({required String email})
  async{
    return await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email);
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///send Otp
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String error) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? "Verification Failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}


////verify otp
Future<void> verifyOTP({
  required String verificationId,
  required String smsCode,
  required Function(String message) onSuccess,
  required Function(String error) onError,
}) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    onSuccess("Phone Verified Successfully");
  } catch (e) {
    onError("Invalid OTP");
  }

}