import 'package:json_annotation/json_annotation.dart';

import 'package:yaallo/features/home/data/model/post_api_model.dart';

part 'home_dto.g.dart';

@JsonSerializable()
class HomeDTO {
  final List<PostAPIModel> data;

  HomeDTO({required this.data});

  factory HomeDTO.fromJson(Map<String, dynamic> json) =>
      _$HomeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDTOToJson(this);

  static HomeDTO toEntity(HomeDTO homeDTO) {
    return HomeDTO(
      data: homeDTO.data,
    );
  }

  static HomeDTO fromEntity(HomeDTO homeDTO) {
    return HomeDTO(
      data: homeDTO.data,
    );
  }
}
