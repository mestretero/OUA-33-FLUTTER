import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oua_flutter33/core/models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<NotificationModel>> getNotifications() {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('notifications')
        .where('receiver_uid', isEqualTo: userId)
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotificationModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(NotificationModel.fromMap(
            element.data() as Map<String, dynamic>, element.id));
      });
      return retVal;
    });
  }

  Future<void> acceptFollowRequest(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'is_active': false,
      'is_read': true,
    });
    // Diğer işlemler
  }

  Future<void> denyFollowRequest(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).delete();
    // Diğer işlemler
  }
}
