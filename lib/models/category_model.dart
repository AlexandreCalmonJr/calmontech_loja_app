// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));



class CategoryModel {
    List<Categoria> categories;

    CategoryModel({
        required this.categories,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Categoria>.from(json["categorias"].map((x) => Categoria.fromJson(x))),
    );

    
}

class Categoria {
    String nome;
    List<String> subcategorias;

    Categoria({
        required this.nome,
        required this.subcategorias,
    });

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        nome: json["nome"],
        subcategorias: List<String>.from(json["subcategorias"].map((x) => x)),
    );

    
}
