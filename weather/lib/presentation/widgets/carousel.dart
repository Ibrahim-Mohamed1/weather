import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<Widget> children;
  final double? height;
  final Axis? scrollDirection;

  const Carousel(
      {super.key, required this.children, this.height, this.scrollDirection});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          CarouselSlider(
            
            items: widget.children
                .map((child) => Builder(
                      builder: (BuildContext context) => Container(
                          width: MediaQuery.of(context).size.width,
                          child: child),
                    ))
                .toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollDirection: widget.scrollDirection ?? Axis.horizontal,
            
              height:
                  MediaQuery.of(context).size.height * (widget.height ?? 0.7),
              onPageChanged: (index, reason) =>
                  setState(() => _currentIndex = index),
              enlargeCenterPage: true,
              aspectRatio: .2,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.children.map((_) {
              int index = widget.children.indexOf(_);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentIndex == index ? Colors.yellow : Colors.grey[600],
                ),
              );
            }).toList(),
          ),
        ],
      );
}
