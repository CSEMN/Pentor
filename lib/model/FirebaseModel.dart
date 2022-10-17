abstract class FirebaseModel{
  String add(FirebaseModel model);
  FirebaseModel get(String documentID);
  bool update(String documentID, FirebaseModel model);
  List<FirebaseModel> all();
  bool delete(String documentID);
}