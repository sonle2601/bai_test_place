class PlaceModel {
  final String title;
  final String addressLabel;

  PlaceModel({required this.title, required this.addressLabel});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'address': {
        'label': this.addressLabel,
      },
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    final title = map['title'] as String?;
    final addressMap = map['address'] as Map<String, dynamic>?;

    if (title == null || addressMap == null || !addressMap.containsKey('label')) {
      return PlaceModel(title: '', addressLabel: '');
    }

    final addressLabel = addressMap['label'] as String?;

    if (addressLabel == null) {
      return PlaceModel(title: '', addressLabel: '');
    }

    return PlaceModel(
      title: title,
      addressLabel: addressLabel,
    );
  }
}
