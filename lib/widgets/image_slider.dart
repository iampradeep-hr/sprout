// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

// CAROUSEL SLIDER FROM SCRATCH

class CarouselSlider extends StatefulWidget {
   List<String> imagesUrl;
   CarouselSlider({
    required this.imagesUrl,
  }) ;
  @override
  State<CarouselSlider> createState() => _CarouselSliderState(imagesUrl);
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final PageController _pageController;

  int pageNo = 0;

  final List<String> images;

  late final Timer carouselTimer;

  _CarouselSliderState(this.images);

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == images.length - 1) {
        pageNo = 0;
      }
      _pageController.animateToPage(pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);

      pageNo++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.95);
    carouselTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (value) {
              pageNo = value;
              setState(() {});
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return child!;
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 4, left: 4, top: 20, bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(images[index]))),
                ),
              );
            },
            // itemCount: images.length,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              images.length,
              (index) => Container(
                    margin: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      size: 8.0,
                      color: pageNo == index
                          ? Colors.indigoAccent
                          : Colors.grey.shade300,
                    ),
                  )),
        )
      ],
    );
  }
}
