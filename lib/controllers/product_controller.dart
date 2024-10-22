import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';  // Certifique-se de importar isso para usar rootBundle
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = <String>[].obs;  // Utilize uma lista observável para reatividade

  getSubcategories(String title) async {
    subcat.clear();  // Limpa as subcategorias anteriores
    try {
      final data = await rootBundle.loadString('lib/services/category_model.json');  // Carrega o JSON
      var decode = categoryModelFromJson(data);  // Decodifica o JSON

      // Filtra categorias que correspondem ao título fornecido
      var filteredCategories = decode.categories.where((element) => element.name == title).toList();
      
      if (filteredCategories.isNotEmpty) {
        // Se encontrar categorias, adiciona as subcategorias à lista
        for (var e in filteredCategories[0].subcategories) {
          subcat.add(e);
        }
      } else {
        // ignore: avoid_print
        print('Nenhuma subcategoria encontrada para o título: $title');  // Mensagem de erro
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao carregar o arquivo JSON: $e');  // Captura de erro
    }
  }

  changeColorIndex(index){
    colorIndex = index;
  }

  increaseQuantity(totalQuantify){
    if(quantity.value<totalQuantify){
      quantity.value++;


    }
      
  }

  decreaseQuantity(){
    if(quantity.value>0){
    quantity.value--;
  }
  }
  calculateTotalPrice(price){
    totalPrice.value = price*quantity.value;
  }

  addToCart({
    required String title,
    required String description,
    required String img,
    
    required String sellername,
    required String sellerid,
    color, qty, tprice,context

  }) async {
       await firestore.collection(cartCollection).doc().set({
        'title':title,
        'description':description,
        'img':img,
        'sellername':sellername,
        'color':color,
        'quantity':qty,
        'totalprice':tprice,
        'status':'normal',
        'added_by': auth.currentUser!.uid,
        'createdtime':DateTime.now()
       }).catchError((error){
        VxToast.show(context, msg: error.toString());
       }
       );
  }

  resetValues(){
    quantity.value = 0;
    totalPrice.value = 0;
    colorIndex.value = 0;
  }








}
