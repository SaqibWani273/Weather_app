import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<Map<String, String?>> getImageAndLottie(String destination) async {
    Map<String, String?> imageAndLottie = {};

    final snapshot =
        await FirebaseFirestore.instance.collection(destination).get();
    //firestore structure :
    //weather_app>background>rain>images>normal
    //...........................>lottie>normal
    for (var element in snapshot.docs) {
      if (element.id == "images") {
        imageAndLottie['image'] = element.data()['image1'];
      } else {
        imageAndLottie['lottie'] = element.data()['normal'];
      }
    }

    return imageAndLottie;
  }
}
