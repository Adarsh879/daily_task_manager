import 'package:daily_task_manager/values/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen((user) {
      _firebaseUser.value = user;
      print('user changed');
    });
    super.onInit();
  }

  Rx<User?> get user => _firebaseUser;

  Stream<User?> get userStream => _auth.authStateChanges();

  Future<String?> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firebaseUser.value = userCredential.user!;
      Get.offAllNamed("/dashboard");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER",
          message: "Sign in aborted by user",
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.offAllNamed("/dashboard");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Sign-in Failed", e.message!,
          backgroundColor: AppColors.redShade4,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAllNamed("/dashboard");
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAllNamed("/login");
  }
}
