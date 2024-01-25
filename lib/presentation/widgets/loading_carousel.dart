import 'dart:async';

import 'package:flutter/material.dart';

class LoadingCarousel extends StatefulWidget {
  @override
  State<LoadingCarousel> createState() => _LoadingCarouselState();
}

class _LoadingCarouselState extends State<LoadingCarousel> {
  int _currentPage = 0;
  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 3 - 1) {
        if (mounted) {
          setState(() {
            _currentPage++;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _currentPage = 0;
          });
        }
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust the height as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 20,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                        child: const CircularProgressIndicator(
                      strokeWidth: 1,
                    )),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          dotBuilder()
        ],
      ),
    );
  }

  Widget dotBuilder() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 6,
              width: _currentPage == index ? 15 : 6,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(_currentPage == index ? 2 : 10),
                color: _currentPage == index
                    ? Colors.indigo
                    : Colors.indigo.withOpacity(0.5),
              ),
            ),
          ),
        )
      ],
    );
  }
}
