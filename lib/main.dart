import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
// import 'package:flutter_app/screens/intro_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/intro_screen.dart';
import 'package:flutter_app/screens/onboarding_screen.dart';
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
        "/": (ctx) => const MyHomePage(),
        "/intro": (ctx) => const IntroScreen(),
        "/sign-up": (ctx) => const RegisterScreen(),
        "/onboarding": (ctx) => const OnboardingScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    await Future.delayed(Duration(seconds: 2));
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
          SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            value: .5,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}


/**
 * AppPage(
        child: Column(
      children: [
        Helpers.createSpacer(x: 10),
        const TextInput(
          label: "Label",
          lines: 10,
          inputType: TextInputType.multiline,
        ),
        const AppTypography(text: "Text"),
        Helpers.createSpacer(x: 10),
        const AppTypography(text: "Text"),
        Helpers.createSpacer(x: 10),
        AppButton("Hello",
            onTapped: () {},
            buttonType: ButtonType.secondary,
            left: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                    border: Border.all(color: secondaryColor, width: 1)),
                child: const Center(
                  child: Icon(
                    Icons.mail,
                    color: secondaryColor,
                  ),
                )))
      ],
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
 */