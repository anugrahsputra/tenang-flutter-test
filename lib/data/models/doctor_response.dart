import 'package:alesha/data/models/doctor_models.dart';
import 'package:equatable/equatable.dart';

class DoctorResponse extends Equatable {
  final List<DoctorModel> doctors;

  const DoctorResponse({
    required this.doctors,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => DoctorResponse(
        doctors: List<DoctorModel>.from((json['data'] as List)
            .map((x) => DoctorModel.fromJson(x))
            .where((element) => element.avatar != null)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(doctors.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [doctors];
}
