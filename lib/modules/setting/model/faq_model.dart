import 'dart:convert';

import 'package:equatable/equatable.dart';

class FaqModel extends Equatable {
  final int id;
  final String title;
  final String question;

  bool isExpanded;

  FaqModel({
    required this.id,
    required this.title,
    required this.question,
    this.isExpanded = false,
  });

  FaqModel copyWith({
    int? id,
    String? title,
    String? question,
    bool? isExpanded,
  }) {
    return FaqModel(
      id: id ?? this.id,
      title: title ?? this.title,
      question: question ?? this.question,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'question': question});
    result.addAll({'isExpanded': isExpanded});

    return result;
  }

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      question: map['question'] ?? '',
      isExpanded: map['isExpanded'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqModel.fromJson(String source) =>
      FaqModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FaqModel(id: $id, title: $title, question: $question, isExpanded: $isExpanded)';
  }

  @override
  List<Object> get props => [id, title, question, isExpanded];
}
