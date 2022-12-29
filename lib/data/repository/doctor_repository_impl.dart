import 'dart:io';

import 'package:alesha/data/datasource/remote_datasource.dart';
import 'package:alesha/domain/entities/doctor.dart';
import 'package:alesha/domain/repository/doctor_repository.dart';
import 'package:alesha/utils/exception.dart';
import 'package:alesha/utils/failure.dart';
import 'package:dartz/dartz.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  DoctorRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getAllDoctors() async {
    try {
      final result = await remoteDataSource.getAllDoctors();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> searchDoctor(String query) async {
    try {
      final result = await remoteDataSource.searchDoctor(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ServerFailure('No Internet Connection'));
    }
  }
}
