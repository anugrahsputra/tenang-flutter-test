import 'package:alesha/data/repository/auth_repository.dart';
import 'package:alesha/firebase_options.dart';
import 'package:alesha/presentation/bloc/auth/auth_bloc.dart';
import 'package:alesha/presentation/pages/home_page.dart';
import 'package:alesha/presentation/pages/sign_in_page.dart';
import 'package:alesha/presentation/pages/sign_up_page.dart';
import 'package:alesha/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Homepage();
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
