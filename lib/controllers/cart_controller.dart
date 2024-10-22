import 'package:get/get.dart';

class CartController extends GetxController{
  var totalP = 0.obs;
  calcule (data){
    totalP.value = 0;
    for (var i = 0 ; i < data.length; i++){
      totalP = totalP + int.parse(data[i]['totalprice'].toString());
    }
    }
  }
