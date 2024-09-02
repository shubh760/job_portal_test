import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<void> storeJobIds(List<String> jobIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId =  prefs.getString('userId');
    try {
      await _firestore.collection('users').doc(userId).set({
        'jobIds': jobIds,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Job IDs stored successfully');
    } catch (e) {
      print('Error storing job IDs: $e');
      rethrow;
    }
  }

  Future<List<String>> fetchJobIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId =  prefs.getString('userId');
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() is Map<String, dynamic>) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('jobIds') && data['jobIds'] is List) {
          return List<String>.from(data['jobIds']);
        }
      }
      return [];
    } catch (e) {
      print('Error fetching job IDs: $e');
      rethrow;
    }
  }
}


