import 'package:equatable/equatable.dart';

class SonanMahgoraEntites extends Equatable {
  final String sona;
  final String name;
  final String type;

  final String textHadith;
  const SonanMahgoraEntites(
      {required this.name,
      required this.sona,
      required this.textHadith,
      required this.type});

  @override
  List<Object?> get props => [
        sona,
        type,
        name,
        textHadith,
      ];
}
