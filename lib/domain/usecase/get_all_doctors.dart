import 'package:alesha/domain/entities/doctor.dart';
import 'package:alesha/domain/repository/doctor_repository.dart';
import 'package:alesha/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctors {
  final DoctorRepository repository;
  GetAllDoctors(
    this.repository,
  );

  Future<Either<Failure, List<Doctor>>> execute() {
    return repository.getAllDoctors();
  }
}
