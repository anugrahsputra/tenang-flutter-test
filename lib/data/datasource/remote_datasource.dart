import 'dart:convert';

import 'package:alesha/data/models/doctor_models.dart';
import 'package:alesha/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors();
  Future<List<DoctorModel>> searchDoctor(String query);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  static const baseUrl = 'https://reqres.in/api';

  final http.Client client;

  DoctorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final response = await client.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> doctors = json['data'];
      return doctors.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DoctorModel>> searchDoctor(query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users'),
      headers: {'query': query},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> doctors = json['data'];
      return doctors
          .map((e) => DoctorModel.fromJson(e))
          .where((doctor) =>
              doctor.firstName.contains(query) ||
              doctor.lastName.contains(query))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
