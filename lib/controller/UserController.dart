import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late User _user;
  StreamSubscription? _userSubscription;

  @override
  void onInit() async {
    super.onInit();
    _watchUserChange();
    await _userInit;
  }

  Future<User> signInAnonymously() async {
    UserCredential userCred = await FirebaseAuth.instance.signInAnonymously();

    int min = 10000;
    int max = 99999;
    int id = Random().nextInt(max - min) + min;
    await userCred.user!.updateDisplayName("User-$id");

    _user = userCred.user!;
    update();
    return _user;
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    _user = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((userCred) => userCred.user!);
    update();
    return _user;
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> get _userInit async {
    if (FirebaseAuth.instance.currentUser != null) {
      _user = FirebaseAuth.instance.currentUser!;
    } else {
      await signInAnonymously();
    }
    update();
  }

  User get user {
    return _user;
  }

  void _watchUserChange() {
    _userSubscription =
        FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user != null) {
        print("USER DATA CHANGED!");
        print(user.uid);
        _user = user;
      } else {
        print("NO USER");
        await signInAnonymously();
      }
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userSubscription?.cancel();
  }
}
