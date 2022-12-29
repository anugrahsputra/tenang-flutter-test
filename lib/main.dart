import 'package:alesha/data/repository/auth_repository.dart';
import 'package:alesha/firebase_options.dart';
import 'package:alesha/presentation/bloc/auth/auth_bloc.dart';
import 'package:alesha/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:alesha/presentation/pages/appointment_page.dart';
import 'package:alesha/presentation/pages/home_page.dart';
import 'package:alesha/presentation/pages/main_page.dart';
import 'package:alesha/presentation/pages/onboard_screen.dart';
import 'package:alesha/presentation/pages/profile_page.dart';
import 'package:alesha/presentation/pages/search_page.dart';
import 'package:alesha/presentation/pages/sign_in_page.dart';
import 'package:alesha/presentation/pages/sign_up_page.dart';
import 'package:alesha/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.dart' as di;

int? isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(create: (context) => di.locator<DoctorBloc>()),
          BlocProvider(create: (context) => di.locator<SearchDoctorBloc>())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                centerTitle: true,
                titleTextStyle: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
              )),
          home: isViewed != 0
              ? const OnboardScreen()
              : StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const MainPage();
                    }
                    return SignIn();
                  },
                ),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case Homepage.routeName:
                return MaterialPageRoute(
                  builder: (context) => Homepage(),
                );
              case SignIn.routeName:
                return MaterialPageRoute(
                  builder: (context) => SignIn(),
                );
              case Signup.routeName:
                return MaterialPageRoute(
                  builder: (context) => Signup(),
                );
              case MainPage.routeName:
                return MaterialPageRoute(
                  builder: (context) => const MainPage(),
                );
              case AppointmentPage.routeName:
                return MaterialPageRoute(
                  builder: (context) => const AppointmentPage(),
                );
              case ProfilePage.routeName:
                return MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                );
              case SearchPage.routeName:
                return MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                );
              case OnboardScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => const OnboardScreen(),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
