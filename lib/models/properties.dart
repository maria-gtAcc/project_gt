import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  List<PropertyInfo> data;
  String message;
  String status;

  PropertyModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        data: List<PropertyInfo>.from(
            json["data"].map((x) => PropertyInfo.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PropertyInfo {
  String propertyId;
  String propertyName;
  List<AvailableSpace> availableSpaces;

  PropertyInfo({
    required this.propertyId,
    required this.propertyName,
    required this.availableSpaces,
  });

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => PropertyInfo(
        propertyId: json["propertyId"],
        propertyName: json["propertyName"],
        availableSpaces: List<AvailableSpace>.from(
            json["availableSpaces"].map((x) => AvailableSpace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "propertyName": propertyName,
        "availableSpaces":
            List<dynamic>.from(availableSpaces.map((x) => x.toJson())),
      };
}

class AvailableSpace {
  String spaceId;
  String propertyName;
  String spaceTitle;
  String spaceDescription;
  double spaceRating;
  int spacePrice;
  List<String> spaceImages;

  AvailableSpace({
    required this.spaceId,
    required this.propertyName,
    required this.spaceTitle,
    required this.spaceDescription,
    required this.spaceRating,
    required this.spacePrice,
    required this.spaceImages,
  });

  factory AvailableSpace.fromJson(Map<String, dynamic> json) => AvailableSpace(
        spaceId: json["spaceId"],
        propertyName: json["propertyName"],
        spaceTitle: json["spaceTitle"],
        spaceDescription: json["spaceDescription"],
        spaceRating: json["spaceRating"],
        spacePrice: json["spacePrice"],
        spaceImages: List<String>.from(json["spaceImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "spaceId": spaceId,
        "propertyName": propertyName,
        "spaceTitle": spaceTitle,
        "spaceDescription": spaceDescription,
        "spaceRating": spaceRating,
        "spacePrice": spacePrice,
        "spaceImages": List<dynamic>.from(spaceImages.map((x) => x)),
      };
}
