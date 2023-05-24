import 'dart:io';

import 'package:chatapp/firebase_service/storage_service.dart';
import 'package:chatapp/model/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  String mediaUrl = '';

  Future<Status> addStatus(String status, XFile pickedFile) async {
    var ref = _firestore.collection("Status");

    mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref.add({'status': status, 'image': mediaUrl});

    return Status(id: documentRef.id, status: status, image: mediaUrl);
  }

  //status göstermek için
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Status").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();

    return ref;
  }
}
