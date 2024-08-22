import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/firbase_console.dart';

class HomeController extends GetxController {
  @override
  // TODO: implement onDelete
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = "";
  var featureList = [];
  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.single['name']) ;
    });
    username = n;
  }
}
