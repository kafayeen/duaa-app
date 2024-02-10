import 'package:equatable/equatable.dart';

class AzkarEntites extends Equatable {
  final String bab;
  final String text;

  const AzkarEntites({
    required this.bab,
    required this.text,
  });

  @override
  List<Object?> get props => [
        bab,
        text,
      ];
}
