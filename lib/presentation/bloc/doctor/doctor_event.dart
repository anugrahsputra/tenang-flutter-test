part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class Doctors extends DoctorEvent {}

class DoctorSearch extends DoctorEvent {
  final String query;

  const DoctorSearch(this.query);

  @override
  List<Object> get props => [query];
}
