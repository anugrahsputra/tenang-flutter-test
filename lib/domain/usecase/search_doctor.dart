import 'package:alesha/domain/entities/doctor.dart';
import 'package:alesha/domain/repository/doctor_repository.dart';
import 'package:alesha/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SearchDoctor {
  final DoctorRepository repository;

  SearchDoctor(this.repository);

  Future<Either<Failure, List<Doctor>>> execute(String query) {
    return repository.searchDoctor(query);
  }
}
