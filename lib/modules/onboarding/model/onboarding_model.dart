import 'dart:convert';

import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final String title;
  final String subTitle;
  final String image;
  final String paragraph;

  const OnBoardingModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.paragraph,
  });

  @override
  List<Object> get props => [title, subTitle, image, paragraph];

  OnBoardingModel copyWith({
    String? title,
    String? subTitle,
    String? image,
    String? paragraph,
  }) {
    return OnBoardingModel(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      image: image ?? this.image,
      paragraph: paragraph ?? this.paragraph,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'subTitle': subTitle});
    result.addAll({'image': image});
    result.addAll({'paragraph': paragraph});

    return result;
  }

  factory OnBoardingModel.fromMap(Map<String, dynamic> map) {
    return OnBoardingModel(
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      image: map['image'] ?? '',
      paragraph: map['paragraph'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoardingModel.fromJson(String source) =>
      OnBoardingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnBoardingModel(title: $title, subTitle: $subTitle, image: $image, paragraph: $paragraph)';
  }
}
