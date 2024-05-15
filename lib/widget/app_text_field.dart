import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/place_view_model.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.placeVM,
  });

  final PlaceViewModel placeVM;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: placeVM.placeController,
      decoration: InputDecoration(
        prefixIcon: Obx(() {
          if(placeVM.isLoading.value){
            return CircularProgressIndicator();
          }else{
            return Icon(Icons.search);
          }
        }),
        hintText: "Enter keyword",
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            placeVM.placeController.clear();
            placeVM.places.clear();
          },
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: (text) {
        if (text.length > 2) {
          placeVM.debounceSearch();
        }
      },
    );
  }
}
