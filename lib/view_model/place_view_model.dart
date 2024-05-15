import 'dart:async';

import 'package:bai_test_map/models/place_model.dart';
import 'package:bai_test_map/repository/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceViewModel extends GetxController {
  final placeController = TextEditingController();

  final _api = PlaceRepository();

  final RxBool isLoading = false.obs;

  var places = <PlaceModel>[].obs;

  Timer? _debounce;

  void debounceSearch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(seconds: 1), () {
      getPlaces();
    });
  }



  Future<void> getPlaces() async {
    try {
      isLoading.value = true;
      List<PlaceModel> placeModels = await _api.fetchSuggestions(placeController.text);
      places.assignAll(placeModels);
      isLoading.value = false;
    } catch (error) {
      print('Error: $error');

      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    placeController.dispose();
    super.dispose();
  }

  void openGoogleMaps(String placeName) async {
    final query = Uri.encodeComponent(placeName);
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}
