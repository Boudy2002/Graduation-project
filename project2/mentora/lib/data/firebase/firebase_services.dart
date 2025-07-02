import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/models/roadmap.dart';

class FirebaseServices {
  static CollectionReference<UserDM> getUserCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference<UserDM> userCollection = db
        .collection("users")
        .withConverter(
          fromFirestore: (snapshot, _) => UserDM.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );

    return userCollection;
  }

  static Future<void> addUserToFireStore(UserDM user) {
    CollectionReference<UserDM> userCollection = getUserCollection();
    DocumentReference<UserDM> userDoc = userCollection.doc(user.id);

    return userDoc.set(user);
  }

  static Future<UserDM> getUserFromFireStore(String userId) async {
    CollectionReference<UserDM> userCollection = getUserCollection();

    // snapshot
    DocumentSnapshot<UserDM> userData = await userCollection.doc(userId).get();

    return userData.data() as UserDM;
  }

  static Future<UserDM?> readUserFromFireStore(String userId) async {
    CollectionReference<UserDM> userCollection = getUserCollection();

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
    CollectionReference<UserDM> userCollection = getUserCollection();
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
      joinedCommunities: [],
      joinedChats: [],
      roadmapId: "",
      milestoneCompletionStatus: []
    );
    await addUserToFireStore(user);
  }

  static Future<void> sigInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    User? firebaseUser = userCredential.user;
    if (firebaseUser == null) return;

    UserDM? myUser = await readUserFromFireStore(firebaseUser.uid);
    if (myUser == null) {
      myUser = UserDM(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
        jobTitle: "",
        joinedCommunities: [],
        joinedChats: [],
        roadmapId: "",
        milestoneCompletionStatus: []
      );
      await addUserToFireStore(myUser);
    }
    UserDM.currentUser = await getUserFromFireStore(myUser.id);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> addRoadmapToFireStore(Roadmap roadmap) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Roadmap> roadmapCollection = db
        .collection("roadmaps")
        .withConverter(
          fromFirestore: (snapshot, _) => Roadmap.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );

    DocumentReference<Roadmap> doc = roadmapCollection.doc(roadmap.id);
    // UserDM.currentUser!.roadmap = roadmap.id;

    return doc.set(roadmap);
  }

  static Future<Roadmap> getRoadmapFromFireStore(String roadmapId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Roadmap> roadmapCollection = db
        .collection("roadmaps")
        .withConverter(
          fromFirestore: (snapshot, _) => Roadmap.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );

    DocumentSnapshot<Roadmap> roadmap =
        await roadmapCollection.doc(roadmapId).get();

    return roadmap.data() as Roadmap;
  }
}
