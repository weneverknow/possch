import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  final String? email;
  final String? documentId;
  final DateTime? loggedinTime;
  const Authentication({
    this.email,
    this.documentId,
    this.loggedinTime,
  });
  @override
  List<Object?> get props => [
        email,
        documentId,
        loggedinTime,
      ];
}
