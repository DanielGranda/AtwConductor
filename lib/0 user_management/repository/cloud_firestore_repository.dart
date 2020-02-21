import 'package:antawaschool/0%20user_management/model/user_adm_model.dart';
import 'package:antawaschool/0%20user_management/services/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreApi = CloudFirestoreApi();

  void updateUserDataFirestore(UserAdmin user) =>
      _cloudFirestoreApi.updateUserData(user);
}
