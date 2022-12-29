import 'package:alesha/data/datasource/remote_datasource.dart';
import 'package:alesha/data/repository/doctor_repository_impl.dart';
import 'package:alesha/domain/repository/doctor_repository.dart';
import 'package:alesha/domain/usecase/get_all_doctors.dart';
import 'package:alesha/domain/usecase/search_doctor.dart';
import 'package:alesha/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(() => DoctorBloc(locator()));
  locator.registerFactory(() => SearchDoctorBloc(locator()));

  locator.registerLazySingleton(() => GetAllDoctors(locator()));
  locator.registerLazySingleton(() => SearchDoctor(locator()));
  locator.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton(() => http.Client());
}
