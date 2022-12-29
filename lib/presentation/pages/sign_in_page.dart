import 'package:alesha/presentation/bloc/auth/auth_bloc.dart';
import 'package:alesha/presentation/pages/main_page.dart';
import 'package:alesha/presentation/pages/sign_up_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 53),
                            child: Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/logo.png')),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'sign in to continue',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8A8D9F),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          emailInput(),
                          const SizedBox(
                            height: 15,
                          ),
                          passwordInput(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget password?',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          button(context),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text('/'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          loginMethod(context),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: GoogleFonts.roboto(
                                  color: const Color(0xff8A8D9F),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Sign Up!',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff4A80FF),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, Signup.routeName);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  loginMethod(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _authenticateWithGoogle(context);
          },
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/Icon_Google.png',
              height: 18,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/Icon_Apple.png',
              height: 18,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/Icon_Facebook.png',
              height: 18,
            ),
          ),
        ),
      ],
    );
  }

  button(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _authenticateWithEmailAndPassword(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4A80FF),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            )),
        child: Text(
          'Sign in',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  passwordInput() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: _passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(
          Icons.lock,
          color: Color(0xff4A80FF),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,

        fillColor: const Color(0xffF4F5F7),
        contentPadding: const EdgeInsets.only(
          top: 15,
        ), // add padding to adjust text
        isDense: true,
      ),
      validator: (value) {
        return value != null && value.length < 6
            ? "Enter min. 6 characters"
            : null;
      },
    );
  }

  emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(
          Icons.email,
          color: Color(0xff4A80FF),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: const Color(0xffF4F5F7),
        contentPadding: const EdgeInsets.only(
          top: 15,
        ), // add padding to adjust text
        isDense: true,
      ),
      validator: (value) {
        return value != null && !EmailValidator.validate(value)
            ? 'Enter a valid email'
            : null;
      },
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      // If email is valid adding new Event [SignInRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
