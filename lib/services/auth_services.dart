import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/pages/fetch_page.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {    
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null) {
        try {
          final authResult = await firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );

          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('usuarios')
                .doc(authResult.user!.uid)
                .set({
              'id': authResult.user!.uid,
              'nombre': authResult.user!.displayName,
              'email': authResult.user!.email,
              'direccion-envio': '',
              'lista': [],
              'carrito': [],
              'creado': Timestamp.now(),
            });
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FetchPage(),
            ),
          );
        } catch (error) {
          GlobalActions.errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
        final UserCredential =
            await firebaseAuth.signInWithCredential(credential);
        final firebaseUser = UserCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = AppleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

      default:
        throw UnimplementedError();
    }
  }
}
