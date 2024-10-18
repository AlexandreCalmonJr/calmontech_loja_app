import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var subcat = [];



  getSubategoria(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.nome == title).toList();

    for (var e in s[0].subcategorias){
      subcat.add(e);

    }
    
    



  }

}