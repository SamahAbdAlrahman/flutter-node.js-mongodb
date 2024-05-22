import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name;
  String? username;
  String profession;
  String DOB;
  String titleline;
  String about;
  ProfileModel(
      {required this.DOB,
      required this.about,
      required this.name,
      required this.profession,
      required this.titleline,
       this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
