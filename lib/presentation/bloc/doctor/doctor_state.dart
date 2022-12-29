part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorLoading extends DoctorState {}

class Empty extends DoctorState {}

class Error extends DoctorState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class DoctorHasData extends DoctorState {
  final List<Doctor> doctors;

  const DoctorHasData(this.doctors);

  @override
  List<Object> get props => [doctors];
}
