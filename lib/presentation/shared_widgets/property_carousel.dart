import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PropertyCarousel extends StatefulWidget {
  final List<String> carouselImages;
  final String propertyName;
  final String spaceTitle;
  final String spaceDescription;
  final double spaceRating;
  final int spacePrice;

  PropertyCarousel({
    required this.carouselImages,
    required this.propertyName,
    required this.spaceTitle,
    required this.spaceDescription,
    required this.spaceRating,
    required this.spacePrice,
  });

  @override
  _PropertyCarouselState createState() => _PropertyCarouselState();
}

class _PropertyCarouselState extends State<PropertyCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Stack(
              children: [
                CarouselSlider(
                  items: widget.carouselImages
                      .map(
                        (imageUrl) => CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.carouselImages.map((url) {
                      int index = widget.carouselImages.indexOf(url);
                      return Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(122, 255, 255, 255),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.propertyName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF607385),
                      fontFamily: 'Monserrat',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.spaceTitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3C4955),
                          fontFamily: 'Monserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/review_star.svg',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.spaceRating.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF3C4955),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 184,
                        child: Text(
                          widget.spaceDescription,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Monserrat',
                            color: Color.fromARGB(255, 96, 115, 133),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color(0xFF297BE6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Starting Price',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFF9F9F9),
                                fontFamily: 'Monserrat',
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$${widget.spacePrice.toString()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFF9F9F9),
                                    fontFamily: 'Monserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '/night',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF9F9F9),
                                    fontFamily: 'Monserrat',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
