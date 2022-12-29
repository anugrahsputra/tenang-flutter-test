import 'package:alesha/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  context.read<SearchDoctorBloc>().add(DoctorSearch(query));
                  debugPrint(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search Doctors',
                  hintStyle: GoogleFonts.roboto(),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xff4E4B66),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xffEFF0F6),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SearchDoctorBloc, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DoctorHasData) {
                    debugPrint(state.doctors.toString());
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.doctors.length,
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
                      ),
                    );
                  } else if (state is Error) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'No Result',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
