

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/HomeScreen/HomePage.dart';
import 'package:flutter_application_1/model/login.dart';
import 'package:flutter_application_1/model/statioMOdel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'httpres.dart';

class OnBoardNotifier extends ChangeNotifier {



  createadmin(Superadmin model) {
    AuthHelper.createStation(model).then((response) {
      if (response) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool("logged", true);
        });
        Get.back();
        print(response);
        Get.snackbar("done", "Your are done");
        Get.to(()=>HomeScreen());
      } else if (!response) {
        Get.snackbar("error", "error");
      }
    }).catchError((error) {
      print(model.toJson());
      print(error);
      Get.snackbar(' failed', 'Invalid');
    });
  }
}
