import 'package:alesha/presentation/bloc/auth/auth_bloc.dart';
import 'package:alesha/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:alesha/presentation/pages/search_page.dart';
import 'package:alesha/presentation/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoctorBloc>().add(Doctors());
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _header(user),
                  const SizedBox(height: 30),
                  // search box
                  _searchBox(),
                  const SizedBox(height: 30),
                  // categories list
                  _categories(),
                  const SizedBox(height: 30),
                  // doctor appointment card
                  const Titles(
                    title: 'Today Appointment',
                  ),
                  const SizedBox(height: 20),
                  _appointmentCard(),
                  const SizedBox(height: 30),
                  // top 3 doctor cards
                  const Titles(
                    title: 'Top Doctors',
                  ),
                  const SizedBox(height: 20),
                  _topDoctors()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _topDoctors() {
    return BlocBuilder<DoctorBloc, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DoctorHasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        state.doctors[index].avatar.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Doctor ${state.doctors[index].firstName}',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Specialist in ${index + 1}',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  _appointmentCard() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff4A80FF),
            Color(0xff3462FF),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff3462FF),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You do not have any appointment',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Book an appointment with a doctor',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Book Now'),
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _categories() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4A80FF),
                  Color(0xff3462FF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(
                Icons.vaccines_rounded,
                color: Color(0xffEFF0F6),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4A80FF),
                  Color(0xff3462FF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(
                Icons.local_hospital_rounded,
                color: Color(0xffEFF0F6),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4A80FF),
                  Color(0xff3462FF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(
                Icons.coronavirus_rounded,
                color: Color(0xffEFF0F6),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4A80FF),
                  Color(0xff3462FF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Icon(
                Icons.medication_rounded,
                color: Color(0xffEFF0F6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchBox() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SearchPage.routeName);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              Icons.search,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 10),
            Text(
              'Search',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _header(User user) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              user.displayName ?? 'User',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            user.photoURL ?? 'https://api.multiavatar.com/${user.uid}.png',
          ),
        ),
      ],
    );
  }
}

class Titles extends StatelessWidget {
  const Titles({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
