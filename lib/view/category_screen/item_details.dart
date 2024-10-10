import 'package:emart_app/consts/colors.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {},icon: const Icon(Icons.share)),
          IconButton(onPressed: () {},icon: const Icon(Icons.favorite_outline)),

        ],
      ),
    );
  }
}