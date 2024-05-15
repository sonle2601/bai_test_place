import 'package:bai_test_map/view_model/place_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/app_text_field.dart';
import '../widget/place_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final placeVM = PlaceViewModel();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1,10),
                      color: Colors.grey.withOpacity(0.1),
                    )
                  ]
              ),
              child: AppTextField(placeVM: placeVM),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: placeVM.places.length,
                itemBuilder: (context, index) {
                  final suggestion = placeVM.places[index];
                  final title = suggestion.title;
                  final address = suggestion.addressLabel; // Sửa lỗi đặt tên
                  return PlaceWidget(
                    title: title,
                    address: address,
                    onPress: (){
                      placeVM.openGoogleMaps(title);
                    },
                    placeVM: placeVM,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}

