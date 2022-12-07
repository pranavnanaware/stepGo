import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step/vm/login_state.dart';
import 'package:step/providers/auth.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
            email,
            password,
          );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void signUp(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).signUpWithEmailAndPassword(
            email,
            password,
          );
      FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .set({"email": email});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void signOut() async {
    // SharedPreferences.setMockInitialValues({});
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove("email");
    await ref.read(authRepositoryProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
