import 'package:ecommerse/screens/home/widget/home_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class CarouselCardWidget extends StatelessWidget {
  const CarouselCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final data = Provider.of<ScreenHomeProvider>(context, listen: false);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.275,
      width: MediaQuery.of(context).size.width * 0.90,
      child: CarouselSlider.builder(
        enableAutoSlider: true,
      //  slideTransform: const CubeTransform(),
        unlimitedMode: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: Colors.blue,
          itemSpacing: 25,
          indicatorRadius: 7,
          padding: const EdgeInsets.only(bottom: 12),
        ),
        itemCount: 3,
        slideBuilder: (index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.23,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/shopping 1.webp'),
                fit: BoxFit.fill,
                opacity: 0.7,
              ),
            ),
            child: const HomeCardWidget(),
          );
        },
      ),
    );
  }
}
