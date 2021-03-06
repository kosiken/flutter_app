import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
// import 'package:flutter_app/screens/intro_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/done_screen.dart';
import 'package:flutter_app/screens/intro_screen.dart';
import 'package:flutter_app/screens/onboarding_pages/page_seven.dart';
import 'package:flutter_app/screens/onboarding_pages/page_five.dart';
import 'package:flutter_app/screens/onboarding_pages/page_four.dart';
import 'package:flutter_app/screens/onboarding_pages/page_six.dart';
import 'package:flutter_app/screens/onboarding_pages/page_three.dart';
import 'package:flutter_app/screens/onboarding_pages/page_two.dart';
import 'package:flutter_app/screens/onboarding_pages/page_one.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

import 'db_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => AppState(),
    child: const MyApp(),
  ));
}

final FlexSchemeColor schemeLight = FlexSchemeColor.from(
  primary: primaryColor,
  secondary: secondaryColor,
);

const FlexScheme scheme = FlexScheme.blueWhale;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(colors: schemeLight, scheme: scheme),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const SplashScreen(),
        "/intro": (ctx) => const IntroScreen(),
        "/sign-up": (ctx) => const RegisterScreen(),
        "/onboarding": (ctx) => const PageOne(),
        "/onboarding_page_2": (ctx) => const PageTwo(),
        "/onboarding_page_3": (ctx) => const PageThree(),
        "/onboarding_page_4": (ctx) => const PageFour(),
        "/onboarding_page_5": (ctx) => const PageFive(),
        "/onboarding_page_6": (ctx) => const PageSix(),
        "/onboarding_page_7": (ctx) => const PageSeven(),
        "/done": (ctx) => const DoneScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final db = DBService.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Person? user = await db.getUser();

    var provider = Provider.of<AppState>(context, listen: false);
    provider.user = user;
    await Future.delayed(const Duration(seconds: 2));
    if (user != null) {
      Navigator.of(context).pushNamed("/onboarding");
    } else {
      Navigator.of(context).pushNamed("/intro");
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return AppPage(
      child: Column(
        children: [
          Row(),
          const AppTypography(text: "Loading"),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator()
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
