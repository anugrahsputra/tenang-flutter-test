import 'package:alesha/domain/entities/doctor.dart';
import 'package:alesha/domain/usecase/get_all_doctors.dart';
import 'package:alesha/domain/usecase/search_doctor.dart';
import 'package:alesha/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetAllDoctors getAllDoctors;

  DoctorBloc(this.getAllDoctors) : super(Empty()) {
    on<Doctors>((event, emit) async {
      emit(DoctorLoading());
      final result = await getAllDoctors.execute();
      result.fold(
        (failure) => emit(Error(failure.message)),
        (doctors) => emit(DoctorHasData(doctors)),
      );
    });
  }
}

class SearchDoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final SearchDoctor searchDoctor;

  SearchDoctorBloc(this.searchDoctor) : super(Empty()) {
    on<DoctorSearch>(
      (event, emit) async {
        emit(DoctorLoading());
        final result = await searchDoctor.execute(event.query);
        result.fold((failure) {
          emit(Error(failure.message));
        }, (doctors) {
          DoctorHasData(doctors);
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
