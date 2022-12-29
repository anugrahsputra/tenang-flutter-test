import 'package:alesha/domain/entities/doctor.dart';
import 'package:alesha/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<Doctor>>> getAllDoctors();
  Future<Either<Failure, List<Doctor>>> searchDoctor(String query);
}
