import 'package:click/data/network/firebase_auth_service.dart';
import 'package:click/data/network/response.dart';

class AuthRepository {
  Future<NetworkResponse> signUp(String email, String password) async =>
      await FirebaseAuthService().signUpWithEmailPassword(email, password);
Future<NetworkResponse> signIn(String email, String password) async =>
      await FirebaseAuthService().signInWithEmailPassword(email, password);
 logOut() => FirebaseAuthService().signOut();

}