// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boardingmodel {
  final String image;
  final String title;
  final String body;
  Boardingmodel({required this.image, required this.body, required this.title});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<Boardingmodel> boarding = [
    Boardingmodel(
        image: 'assets/images/onboarding.png',
        body: 'on board 1 body',
        title: 'on board 1 title'),
    Boardingmodel(
        image: 'assets/images/onboarding.png',
        body: 'on board 2 body',
        title: 'on board 2 title'),
    Boardingmodel(
        image: 'assets/images/onboarding.png',
        body: 'on board 3 body',
        title: 'on board 3 title')
  ];
  bool islast = false;
  void submit() {
    Cashe_Helper.savedata(key: 'on boarding', value: true).then((value) {
      if (value) {
        navigateandfinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaulttextbutton(
              fuction:submit,
              text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                itemBuilder: (context, index) =>
                    buildboardingitem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: Colors.blue,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      boardcontroller.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildboardingitem(Boardingmodel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
