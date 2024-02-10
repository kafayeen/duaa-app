import 'package:equatable/equatable.dart';

class Hadith extends Equatable {
  final String hadith;
  final String name;
  final String textHadith;

  const Hadith({
    required this.name,
    required this.hadith,
    required this.textHadith,
  });

  @override
  List<Object?> get props => [
        hadith,
        name,
        textHadith,
      ];
}
