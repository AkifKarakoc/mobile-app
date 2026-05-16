import 'package:json_annotation/json_annotation.dart';

part 'complete_route_stop_response.g.dart';

@JsonSerializable()
class CompleteRouteStopResponse {
  final String stopId;
  final bool routeCompleted;
  final int expEarned;
  final double distance;

  CompleteRouteStopResponse({
    required this.stopId,
    required this.routeCompleted,
    required this.expEarned,
    required this.distance,
  });

  factory CompleteRouteStopResponse.fromJson(Map<String, dynamic> json) =>
      _$CompleteRouteStopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteRouteStopResponseToJson(this);
}
