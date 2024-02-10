import 'package:equatable/equatable.dart';

class Tanawoh extends Equatable {
  final String key;
  final String name;
  final String textHadith;
  final String explanationHadith;
  final String translateNarrator;
  final String audioHadith;
  const Tanawoh(
      {required this.key,
      required this.explanationHadith,
      required this.name,
      required this.textHadith,
      required this.translateNarrator,
      required this.audioHadith});

  @override
  List<Object?> get props => [
        key,
        name,
        textHadith,
        explanationHadith,
        translateNarrator,
        audioHadith
      ];
}
