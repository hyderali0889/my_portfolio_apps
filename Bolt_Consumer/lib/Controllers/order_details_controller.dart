import 'package:get/get.dart';

import '../Constants/firebase_const.dart';

class OrderDetailsController extends GetxController {
  RxList products = [].obs;
  RxInt sum = 0.obs;

  addDataToProductsList(item) {
    products.add(item);
  }

  concludeSum() {
    sum.value = 0;
    for( var ele in products ){
        sum +=
          ele[ProductModelConsts().price] * ele[ProductModelConsts().quantity];
     }
  }

  updateQuantity(ind, quan) {
    products[ind][ProductModelConsts().quantity] = quan;
    concludeSum();
  }
}
