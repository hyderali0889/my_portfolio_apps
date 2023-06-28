import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList notifications = [].obs;

  addNotifications(List name) {
    notifications.add(name);
  }
}
