import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheelie/Screens/pickupScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ((context) => PickUpScreen())),
                        (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "skip",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: onBoardData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: ((context, index) => OnBoardingContent(
                      image: onBoardData[index].image,
                      title: onBoardData[index].title,
                      description: onBoardData[index].description))),
            ),
            Row(
              children: [
                ...List.generate(
                    onBoardData.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: DotIndicator(
                            primaryColor: primaryColor,
                            isActive: index == _pageIndex,
                          ),
                        )),
                Spacer(),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: primaryColor),
                    onPressed: (() {
                      if (_pageIndex == (onBoardData.length - 1)) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => PickUpScreen())),
                            (route) => false);
                      }
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }),
                    child: SvgPicture.asset(
                      'images/icons/right-arrow.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
    required this.primaryColor,
  }) : super(key: key);

  final Color primaryColor;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 4,
      height: isActive ? 12 : 4,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : primaryColor.withOpacity(.4),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  final String image, title, description;
  const OnBoardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        new SvgPicture.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade500),
        ),
        const Spacer(),
      ],
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> onBoardData = [
  Onboard(
    image: 'images/onboard/best-price4.svg',
    title: "Better Price",
    description:
        "We offer users special deals and discounta and provide users with the ability to compare rental rates from multiple car rental companies and choose the best deal for them.",
  ),
  Onboard(
    image: 'images/onboard/free-cancellation.svg',
    title: "Free Cancellation",
    description:
        "We offer a range of cancellation options for users, including free cancellations up to a certain time period before the rental starts or the ability to cancel and receive a partial refund.",
  ),
  Onboard(
    image: 'images/onboard/instant-cnfirmation.svg',
    title: "Instant Confirmation",
    description:
        "We offer responsive and helpful customer support services, including live chat, phone support, or an online help cente",
  ),
  Onboard(
    image: 'images/onboard/Car driving-cuate.svg',
    title: "Continuous Availability",
    description:
        "We provide a wide range of vehicles to choose from, including different makes and models, sizes, and features such as GPS, entertainment systems, and safety features.",
  ),
];
