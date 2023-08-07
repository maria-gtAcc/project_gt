import 'package:flutter/material.dart';
import '../models/properties.dart';
import '../service/property_service.dart';

class PropertyProvider with ChangeNotifier {
  PropertyService property = PropertyService();

  List<PropertyInfo> _properties = [];
  List<PropertyInfo> get properties => _properties;

  PropertyInfo? _selectedProperty;
  PropertyInfo? get selectedProperty => _selectedProperty;

  Future<void> fetchAvailableProperties() async {
    _properties = await property.getAllAvailableProperties();
    notifyListeners();
  }

  void setSelectedProperty(PropertyInfo? property) {
    _selectedProperty = property;
    notifyListeners();
  }

  int getTotalAvailableProperties(PropertyInfo property) {
    return property.availableSpaces.length;
  }
}
