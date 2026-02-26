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
}