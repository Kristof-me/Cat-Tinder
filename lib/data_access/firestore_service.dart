import 'package:cat_tinder/data_access/cat_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // we could use the limit to implement pagination but its not necessary for this app
  // final int limit = 10;

  void addRating(String userId, CatInformation catId, bool isLike) async {
    final collection = FirebaseFirestore.instance.collection(_getPath(userId, isLike));

    collection.doc(catId.id).set({
      'id': catId.id,
      'imageUrl': catId.imageUrl,
      'tags': catId.tags
    });
  }

  Future<QuerySnapshot> getRatings(String userId, bool isLike, DocumentSnapshot? lastDoc) {
    if (lastDoc != null) {
      return FirebaseFirestore.instance.collection(_getPath(userId, isLike))
      .startAfterDocument(lastDoc)
      .get();
    }

    return FirebaseFirestore.instance.collection(_getPath(userId, isLike))
      .get();
  }

  String _getPath(String userId, bool isLike) {
    return 'ratings/$userId/${isLike ? 'likes' : 'dislikes'}';
  }

}