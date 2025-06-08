import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/data/DM/user_dm.dart';

class FirebaseServices {
  static Future<CollectionReference<UserDM>> getUserCollection() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference<UserDM> userCollection = db
        .collection("users")
        .withConverter(
          fromFirestore: (snapshot, _) => UserDM.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );

    return userCollection;
  }

  static Future<void> addUserToFireStore(UserDM user) async {
    CollectionReference<UserDM> userCollection = await getUserCollection();
    DocumentReference<UserDM> userDoc = userCollection.doc(user.id);

    return userDoc.set(user);
  }

  static Future<UserDM> getUserFromFireStore(String userId) async {
    CollectionReference<UserDM> userCollection = await getUserCollection();

    // snapshot
    DocumentSnapshot<UserDM> userData = await userCollection.doc(userId).get();

    return userData.data() as UserDM;
  }

  static Future<UserDM?> readUserFromFireStore(String userId) async {
    CollectionReference<UserDM> userCollection = await getUserCollection();

    // snapshot
    DocumentSnapshot<UserDM> userData = await userCollection.doc(userId).get();

    return userData.data();
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    UserDM user = await getUserFromFireStore(credential.user!.uid);
    UserDM.currentUser = user;
  }

  static Future<void> updateUserData(UserDM user) async {
    CollectionReference<UserDM> userCollection = await getUserCollection();
    DocumentReference<UserDM> userDoc = userCollection.doc(user.id);

    return userDoc.set(user);
  }

  static Future<void> register(
    String email,
    String password,
    String name,
  ) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserDM user = UserDM(
      id: credential.user!.uid,
      name: name,
      email: email,
      jobTitle: "",
    );
    await addUserToFireStore(user);
  }

  static Future<void> sigInWithGoogle(BuildContext context) async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    User? firebaseUser = userCredential.user;
    if(firebaseUser == null ) return;

    UserDM? myUser = await readUserFromFireStore(firebaseUser.uid);
    if(myUser == null){
      myUser = UserDM(id: firebaseUser.uid, name: firebaseUser.displayName ?? "", email: firebaseUser.email ?? "", jobTitle: "");
      await addUserToFireStore(myUser);
    }
    UserDM.currentUser =  await getUserFromFireStore(myUser.id);
  }

  static Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }
}
