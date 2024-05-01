import 'package:click/data/models/user_model.dart';
import 'package:click/data/network/response.dart';
import 'package:click/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        emit(AuthLoadState(isLoad: true));
        if (event.userModel.password == event.confirmPassword) {
          NetworkResponse networkResponse = await AuthRepository()
              .signUp(event.userModel.email, event.userModel.password);
          if (networkResponse.errorText != null) {
            emit(AuthSuccessState(networkResponse.data));
          } else {
            emit(AuthErrorState(networkResponse.errorText.toString()));
          }
        } else {
          emit(AuthErrorState("Sizning parolingiz mos kelmadi"));
        }
      } catch (e) {
        emit(AuthErrorState('$e'));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoadState(isLoad: true));
        NetworkResponse networkResponse =
            await AuthRepository().signIn(event.email, event.password);
        if (networkResponse.errorText != null) {
          emit(AuthSuccessState(networkResponse.data));
        } else {
          emit(AuthErrorState(networkResponse.errorText.toString()));
        }
      } catch (e) {
        emit(AuthErrorState('$e'));
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        emit(AuthLoadState(isLoad: true));
        NetworkResponse networkResponse =
            await AuthRepository().logOut();
        if (networkResponse.errorText != null) {
          emit(AuthSuccessState(networkResponse.data));
        } else {
          emit(AuthErrorState(networkResponse.errorText.toString()));
        }
      } catch (e) {
        emit(AuthErrorState('$e'));
      }
    });
  }
}
// Future<void> signInWithGoogle(BuildContext context,
//     [String? clientId]) async {
//   // Trigger the authentication flow
//   _notify(true);
//
//   final GoogleSignInAccount? googleUser =
//   await GoogleSignIn(clientId: clientId).signIn();
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//   await googleUser?.authentication;
//
//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   // Once signed in, return the UserCredential
//   UserCredential userCredential =
//   await FirebaseAuth.instance.signInWithCredential(credential);
//   _notify(false);
//   if (userCredential.user != null) {
//     Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
//   }
// }
