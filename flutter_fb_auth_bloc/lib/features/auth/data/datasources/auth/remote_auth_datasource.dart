import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/core/util/auth/change_password_success_response.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RemoteAuthDatasource {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 
  
  User? get currentUser => firebaseAuth.currentUser;
  
  Future<UserCredential> login({required String email, required String password}) async{
    try {
      return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    
  }
  Future<UserCredential> signup({required String email, required String password}) async{
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    
  }
  Future<void> logout() async{
    return firebaseAuth.signOut();
  }
 Future<UserCredential> signInWithGoogle() async {
  try {
     final googleSignIn = GoogleSignIn();
     //logout user first to allow them to select an email
     await googleSignIn.signOut();
    // 1. Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
       throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    // 2. Get the Google authentication details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 3. Create a new credential for Firebase
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    // 4. Sign in to Firebase with the credential
    return await firebaseAuth.signInWithCredential(credential);

  } on FirebaseAuthException catch (e) {
    print(e.message);
    throw FirebaseAuthException(code: e.code, message: e.message);
  } catch (e) {
    print("Unexpected error: $e");
    rethrow;
  }
}
Future<ChangePasswordResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
  try {
    User? user = firebaseAuth.currentUser;
    if (user == null) {
      return ChangePasswordResponse(success: false, message: 'User Not Logged In');
    }
    final credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(credential);
    // If reauthentication is successful, change the password.
    await user.updatePassword(newPassword);
    return ChangePasswordResponse(success: true, message: 'Password updated successfully');
  } catch (e) {
    print('Error while calling change password api: $e');
    return ChangePasswordResponse(success: false, message: e.toString());
  }
}
Future<void> forgotPassword({required String email}) async{
  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  } catch (e) {
    rethrow;
  }
}

}