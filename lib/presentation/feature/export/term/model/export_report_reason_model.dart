// Package imports:
import 'package:equatable/equatable.dart';

sealed class ExportReportReasonModel extends Equatable {
  const ExportReportReasonModel();

  const factory ExportReportReasonModel.noReason() = ExportReportNoReason._;

  const factory ExportReportReasonModel.useForPersonal() = ExportReportUseForPersonalReason._;

  const factory ExportReportReasonModel.shareClinic({
    String doctorName,
    String clinicInformation,
  }) = ExportReportShareClinicReason._;

  bool get isValid;
}

final class ExportReportNoReason extends ExportReportReasonModel {
  const ExportReportNoReason._();

  @override
  bool get isValid => false;

  @override
  List<Object?> get props => [];
}

final class ExportReportUseForPersonalReason extends ExportReportReasonModel {
  const ExportReportUseForPersonalReason._();

  @override
  bool get isValid => true;

  @override
  List<Object?> get props => [];
}

final class ExportReportShareClinicReason extends ExportReportReasonModel {
  const ExportReportShareClinicReason._({
    this.doctorName = '',
    this.clinicInformation = '',
  });

  final String doctorName;
  final String clinicInformation;

  @override
  bool get isValid => doctorName.trim().isNotEmpty && clinicInformation.trim().isNotEmpty;

  ExportReportShareClinicReason copyWith({
    String? doctorName,
    String? clinicInformation,
  }) {
    return ExportReportShareClinicReason._(
      doctorName: doctorName ?? this.doctorName,
      clinicInformation: clinicInformation ?? this.clinicInformation,
    );
  }

  @override
  List<Object?> get props => [
        doctorName,
        clinicInformation,
      ];
}
