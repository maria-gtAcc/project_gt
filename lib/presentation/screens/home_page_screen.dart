import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../models/properties.dart';
import '../../provider/property_provider.dart';
import '../shared_widgets/property_carousel.dart';
import '../shared_widgets/side_menu.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Provider.of<PropertyProvider>(context, listen: false)
        .fetchAvailableProperties();
  }

  @override
  Widget build(BuildContext context) {
    List<PropertyInfo> properties =
        Provider.of<PropertyProvider>(context).properties;
    PropertyInfo selectedProperty =
        Provider.of<PropertyProvider>(context).selectedProperty ??
            properties.first;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 73, 85, 1),
        toolbarHeight: 160,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        title: Column(
          children: [
            SizedBox(height: 5),
            Row(children: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: SvgPicture.asset(
                  'assets/icons/burger_menu.svg',
                  color: Colors.white,
                  width: 20,
                ),
              ),
              Container(
                width: 305,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                    color: Color.fromRGBO(178, 187, 202, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<PropertyInfo>(
                  value: selectedProperty,
                  items: properties.map<DropdownMenuItem<PropertyInfo>>((prop) {
                    return DropdownMenuItem<PropertyInfo>(
                      value: prop,
                      key: ValueKey(prop.propertyId),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 24.0, 0),
                        child: Text(
                          prop.propertyName,
                          style: TextStyle(
                            color: Color.fromRGBO(50, 62, 72, 1),
                            fontSize: 14.0,
                            fontFamily: 'Monserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (prop) {
                    Provider.of<PropertyProvider>(context, listen: false)
                        .setSelectedProperty(prop);
                  },
                  hint: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 160.0, 0),
                    child: Text(
                      'Select property',
                      style: TextStyle(
                        color: Color.fromRGBO(178, 187, 202, 1),
                        fontSize: 14.0,
                        fontFamily: 'Monserrat',
                      ),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5.0, 0),
                  child: Container(
                    width: 168,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(249, 249, 249, 1),
                      border: Border.all(
                        color: Color.fromRGBO(178, 187, 202, 1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      value: null,
                      items: [],
                      onChanged: (value) {},
                      hint: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 40, 0),
                        child: Text(
                          'Select Dates',
                          style: TextStyle(
                            color: Color.fromRGBO(178, 187, 202, 1),
                            fontSize: 14.0,
                            fontFamily: 'Monserrat',
                          ),
                        ),
                      ),
                      icon: Icon(Icons.arrow_right_outlined),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 165.5,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(249, 249, 249, 1),
                    border: Border.all(
                      color: Color.fromRGBO(178, 187, 202, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<String>(
                    value: null,
                    items: [],
                    onChanged: (value) {},
                    hint: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 7, 0),
                      child: Text(
                        'Guests & Rooms',
                        style: TextStyle(
                          color: Color.fromRGBO(178, 187, 202, 1),
                          fontSize: 14.0,
                          fontFamily: 'Monserrat',
                        ),
                      ),
                    ),
                    icon: Icon(Icons.arrow_right_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 0, 15),
            child: Text(
              'Available Spaces',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Monserrat',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(50, 62, 72, 1),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Provider.of<PropertyProvider>(context, listen: false)
                  .getTotalAvailableProperties(selectedProperty),
              itemBuilder: (context, index) {
                return PropertyCarousel(
                  carouselImages:
                      selectedProperty.availableSpaces[index].spaceImages,
                  propertyName: selectedProperty.propertyName,
                  spaceTitle:
                      selectedProperty.availableSpaces[index].spaceTitle,
                  spaceDescription:
                      selectedProperty.availableSpaces[index].spaceDescription,
                  spaceRating:
                      selectedProperty.availableSpaces[index].spaceRating,
                  spacePrice:
                      selectedProperty.availableSpaces[index].spacePrice,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
