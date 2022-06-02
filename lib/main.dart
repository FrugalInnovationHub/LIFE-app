import 'package:flutter/material.dart';
import 'package:passage_flutter/main_pages/filter.dart';
import 'package:passage_flutter/main_pages/home.dart';
import 'package:passage_flutter/main_pages/learning_page.dart';
import 'package:passage_flutter/main_pages/welcome.dart';
import 'package:passage_flutter/other_pages/awards_pages/lifetime_water.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_room.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:passage_flutter/other_pages/guided_lesson_pages/data_storage/learning_progress_model.dart';
import 'package:passage_flutter/other_pages/guided_lesson_pages/guided_lessons/components/finish_page.dart';
import 'package:passage_flutter/other_pages/guided_lesson_pages/guided_lessons/science_lesson.dart';
import 'package:passage_flutter/other_pages/resource_pages/about_resources.dart';
import 'package:passage_flutter/other_pages/resource_pages/admin_page.dart';
import 'package:passage_flutter/other_pages/resource_pages/filter_resources.dart';
import 'package:passage_flutter/other_pages/resource_pages/check_page.dart';
import 'package:passage_flutter/other_pages/resource_pages/teacher_resources.dart';
import 'package:passage_flutter/other_pages/settings_page.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import '/components/custom_app_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Every time pub get is run, implicit/ex the IDE (V.S. Code) thinks this^ package doesn't exist. Not an error, just reload.
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() {
  // Call this manually before setpreferred orientation
  WidgetsFlutterBinding.ensureInitialized();

  //set preferred orientation then run app
  //set preferred orientation currently used since only one orientation was designed for
  //Documentation: https://greymag.medium.com/flutter-orientation-lock-portrait-only-c98910ebd769
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale.fromSubtags(languageCode: 'en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TrophyProgressStore()),
          ChangeNotifierProvider(create: (context) => LearningProgressStore()),
          ChangeNotifierProvider(create: (context) => WaterStore()),
        ],
        child: MaterialApp(
          title: 'LIFE APP',
          initialRoute: '/',
          routes: {
            '/': (context) => const MainNavigation(),
            //lessons page has active state which is the progress.
            '/scienceLessonOne': (context) => const ScienceLesson(),
            //Resource Pages
            '/teacherResources': (context) => const TeacherResources(),
            '/checkPage': (context) => const CheckPage(),
            '/filterResources': (context) => const FilterResources(),
            '/aboutResources': (context) => const AboutResources(),
            //Awards Pages
            '/lifetimeWater': (context) => const LifetimeWater(),
            '/trophyRoom': (context) => const TrophyRoom(),
            '/finishPage': (context) => const FinishPage(),
            '/adminPage': (context) => const AdminPage(),
            '/settingsPage': (context) => SettingsPage(changeLocale: setLocale),
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Spanish, no country code
          ],
          locale: _locale,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        ));
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  //initialized at 0 to start on the welcome screen
  int _selectedIndex = 0;
  //specific use case - if main is pushed to stack and you want to choose which
  //index to start on. Only true on first time main is pushed to stack, so that
  //if context is popped and we go back to main, it automatically remembers where
  //we were.
  bool _firstUpdate = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _firstUpdate = false;
    });
  }

  //4 main pages
  static final List<Widget> _pages = <Widget>[
    const WelcomePage(),
    const Home(),
    const LearningPage(),
    const FiltersHome()
  ];

  @override
  Widget build(BuildContext context) {
    //only done on first update - used to push argument to named path so that you can
    //navigate to one of the pages
    //ONLY NEEDED WHEN PUSHING NEW NAMED ROUTE - used to get around pdfx problem
    if (_firstUpdate) {
      int _startingIndex = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as int
          : _selectedIndex;

      setState(() {
        _selectedIndex = _startingIndex;
      });
      _firstUpdate = false;
    }

    return Scaffold(
        appBar: customAppBar(context, 'LIFE'),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 250, right: 250, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppTheme.colors.lightBlue, width: 3),
              boxShadow: [
                BoxShadow(
                  color: const AppColors().shadowColor,
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                  spreadRadius: 3,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BottomNavyBar(
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    icon: const Icon(Icons.waving_hand),
                    title: const Text('Welcome'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.house),
                    title: const Text('Home'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.local_library),
                    title: const Text('Learn'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.water_drop),
                    title: const Text('Filter'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onItemSelected: _onItemTapped,
              ),
            ),
          ),
        ),
        //allows for content to go under the floating nav bar
        extendBody: true,
        body: _pages[_selectedIndex]);
  }
}
