import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RatingEntity extends Equatable {
  @JsonKey(name: 'rate')
  final double productRating;
  @JsonKey(name: 'count')
  final int productCount;

  const RatingEntity({required this.productRating, required this.productCount});

  @override
  List<Object?> get props => [productRating, productCount];

  factory RatingEntity.fromJson(Map<String, Object?> json) =>
      _$RatingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RatingEntityToJson(this);
}
