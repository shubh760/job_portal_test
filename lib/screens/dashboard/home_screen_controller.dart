import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:job_portal/api/api_service.dart';
import 'package:job_portal/models/data_model.dart';
import 'package:job_portal/services/firebase/firestore_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  var isLoading = true.obs;
  List dataList = [].obs;
  RxList<String> jobIds = [""].obs;
  final userId = RxnString();
  final FirestoreServices _firestoreService = FirestoreServices();

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('userId');
    fetchData();
    fetchJobIdsFromFirestore();
  }

  fetchData() async {
    isLoading.value = true;
    try {
      final response = await ApiService().get(
        'https://jsonplaceholder.typicode.com/albums/1/photos',
      );
      log(response.body);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        for (var item in data) {
          dataList.add(GetImageData(
            id: item['id'],
            title: item['title'],
            albumId: item['albumId'],
            thumbnailUrl: item['thumbnailUrl'],
            url: item['url'],
          ));
        }
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> storeJobIdsInFirestore(List<String> newJobIds) async {
    if (userId.value != null) {
      print(userId.value);
      try {
        await _firestoreService.storeJobIds(newJobIds);
        jobIds.value = newJobIds;
        Get.snackbar('Success', 'Job Applied Successfully');
        fetchJobIdsFromFirestore();
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', 'Failed to store Job IDs: $e');
      }
    } else {
      Get.snackbar('Error', 'No user ID available');
    }
  }

  Future<void> fetchJobIdsFromFirestore() async {
    if (userId.value != null) {
      try {
        List<String> fetchedJobIds = await _firestoreService.fetchJobIds();
        jobIds.value = fetchedJobIds;
        // Get.snackbar('Success', 'Fetched ${fetchedJobIds.length} Job IDs');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', 'Failed to fetch Job IDs: $e');
      }
    } else {
      Get.snackbar('Error', 'No user ID available');
    }
  }
}
