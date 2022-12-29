import 'package:alesha/presentation/pages/sign_in_page.dart';
import 'package:alesha/presentation/widgets/on_board_page_last_widget.dart';
import 'package:alesha/presentation/widgets/on_board_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/auth/auth_bloc.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);
  static const routeName = '/onboard';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
        },
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                const OnboardPage(
                  image: 'assets/medical.png',
                  title: 'Welcome To Alesha',
                ),
                const OnboardPage(
                  image: 'assets/medicine.png',
                  title: 'Find Best Doctors',
                ),
                OnboardPageLast(
                  image: 'assets/yoga.png',
                  title: 'Get Fitness Trips',
                  onPressed: () async {
                    await _storeOnBoardInfo();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Container(
              alignment: const Alignment(0.80, 0.90),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                    dotWidth: 12,
                    dotHeight: 12,
                    dotColor: Color(0xffEFF0F6),
                    activeDotColor: Color(0xff8A8D9F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
