import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingcontroller = PageController();

  bool islast = false;

  List<boardingmodel> lst = [
    boardingmodel(
        image: 'assets/images/onboarding1.jpg', title: "Title 1 ", body: "Body 1"),
    boardingmodel(
        image: 'assets/images/onboarding2.jpg', title: "Title 2 ", body: "Body 2"),
    boardingmodel(
        image: 'assets/images/onboarding3.jpg', title: "Title 3 ", body: "Body 3"),
  ];

  void onSubmit()
  {
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShopLoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: onSubmit,
              child: Text(
                "SKIP",
                style: TextStyle(color: Colors.deepOrange),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) => builditem(lst[index]),
              itemCount: lst.length,
              onPageChanged: (int index) {
                if (index == lst.length - 1) {
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
              controller: boardingcontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingcontroller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                    )),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (islast) {
                      onSubmit();
                    } else {
                      boardingcontroller.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget builditem(boardingmodel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Image.asset(
      "${model.image}",
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    ),
    SizedBox(
      height: 30,
    ),
    Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      height: 15,
    ),
    Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Text(
        "${model.body}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ),
    SizedBox(
      height: 40,
    ),
  ],
);

class boardingmodel {
  final String image;
  final String title;
  final String body;

  boardingmodel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}
