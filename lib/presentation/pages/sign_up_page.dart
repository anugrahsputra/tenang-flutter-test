import 'package:alesha/presentation/bloc/auth/auth_bloc.dart';
import 'package:alesha/presentation/pages/main_page.dart';
import 'package:alesha/presentation/pages/sign_in_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, MainPage.routeName);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Sign Up',
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Create new account',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: const Color(0xff8A8D9F),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              return value != null &&
                                      !EmailValidator.validate(value)
                                  ? 'Enter a valid email'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _createAccountWithEmailAndPassword(context);
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
                                'Sign up',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff8A8D9F),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In!',
                              style: GoogleFonts.roboto(
                                color: const Color(0xff4A80FF),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, SignIn.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _fullNameController.text,
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }
}
