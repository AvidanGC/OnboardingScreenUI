import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Page Indicator Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2 );
          },
          children: [
              BuildPageWidget(
                  color: Colors.green.shade100,
                  image: "assets/images/mode1.svg",
                  title: "Let's Travelling",
                  subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam et hendrerit tortor. Donec pellentesque sem ut orci gravida convallis quis et est."),
             BuildPageWidget(
                  color: Colors.green.shade100,
                  image: "assets/images/mode2.svg",
                  title: "Let's Travelling",
                  subtitle: "Suspendisse faucibus lectus non ligula consequat pellentesque. Mauris id tellus eu felis venenatis elementum id nec urna. Cras dictum est aliquet placerat vehicula."),
              BuildPageWidget(
                  color: Colors.green.shade100,
                  image: "assets/images/mode3.svg",
                  title: "Let's Travelling",
                  subtitle: "Suspendisse faucibus lectus non ligula consequat pellentesque. Mauris id tellus eu felis venenatis elementum id nec urna. Cras dictum est aliquet placerat vehicula.")
          ],
        ),
      ),
      bottomSheet: isLastPage
            ? TextButton(
              style: TextButton.styleFrom(
                 shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                primary: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size.fromHeight(80)
              ),
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 24),
                ))
            : Container(
              color: Colors.white10,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(2);
                        },
                        child: const Text("SKIP")),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.black12,
                            activeDotColor: Colors.teal.shade700),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text("NEXT")),
                  ],
                ),
              )
    );
  }
}

class BuildPageWidget extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final String subtitle;

  const BuildPageWidget({
    Key? key,
    required this.color,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SvgPicture.asset(
              image,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Text(title, style: TextStyle(
            color: Colors.teal.shade700, fontSize: 32, fontWeight: FontWeight.bold
          ),),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50 , vertical:20),
            child: Text(subtitle, style: const TextStyle(
            color: Color.fromARGB(255, 57, 76, 74), fontWeight: FontWeight.bold
          ),),
          )
        ],
      ),
    );
  }
}

const colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];