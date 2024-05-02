import 'package:click/data/network/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/extentions/auth_extentions.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<NetworkResponse> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: SignUpWithEmailAndPasswordFailure.fromCode(e.code).message,
      );
    } catch (error) {
      return NetworkResponse(
          errorText: "An unknown exception occurred: $error");
    }
  }


  Future<NetworkResponse> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: LogInWithEmailAndPasswordFailure.fromCode(e.code).message,
      );
    } catch (error) {
      return NetworkResponse(
          errorText: "An unknown exception occurred: $error");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
