// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingEntity _$RatingEntityFromJson(Map<String, dynamic> json) => RatingEntity(
      productRating: (json['rate'] as num).toDouble(),
      productCount: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$RatingEntityToJson(RatingEntity instance) =>
    <String, dynamic>{
      'rate': instance.productRating,
      'count': instance.productCount,
    };
