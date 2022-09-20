import 'package:flutter/material.dart';
import 'package:shop_app_final/modules/login_screen/login_screen.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String header;
  final String body;

  BoardingModel({
    required this.image,
    required this.header,
    required this.body,
  });
}

//ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/shopping.png',
      header: 'Welcome to Market El Market',
      body: 'Everything u need is here !',
    ),
    BoardingModel(
      image: 'assets/images/billing.png',
      header: 'Easy Payment',
      body: 'all ways for payment are available !',
    ),
    BoardingModel(
      image: 'assets/images/cashback2.png',
      header: 'CashBack',
      body: 'cashBack is available always and forever',
    ),
    BoardingModel(
      image: 'assets/images/delivery.png',
      header: 'Super Fast Delivery',
      body: 'Delivery is now free !',
    ),
  ];

  PageController pageController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          myTextButton(
            context: context,
              onTap: () {
                CacheHelper.saveData(key: "onBoarding", value: true).then((value){
                  NavigateTo(context: context, widget: LoginScreen());
                });
              },
              label: "SKIP"),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        buildPageViewScreen(context:context,size: size, model: boarding[index]),
                    itemCount: boarding.length,
                    onPageChanged: (index) {
                      if (index == (boarding.length - 1)) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 5,
                    activeDotColor: Colors.redAccent,
                    dotColor: Colors.grey,
                    dotHeight: 5,
                    dotWidth: 5,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: size.height * 0.05,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      if (isLast) {
                        CacheHelper.saveData(key: "onBoarding", value: true).then((value){
                          NavigateToReb(context: context, widget: LoginScreen());
                        });
                      } else {
                        pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    color: Colors.redAccent,
                    child: !isLast
                        ? const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        : const Text(
                            'GET STARTED',
                            style: TextStyle(
                                fontFamily: "KareemB", color: Colors.white),
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget buildPageViewScreen({
  required BuildContext context,
  required Size size,
  required BoardingModel model,
}) =>
    Column(
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        SizedBox(
          height: size.height * 0.05,
        ),
        Text(
          model.header,
          style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
      ],
    );
