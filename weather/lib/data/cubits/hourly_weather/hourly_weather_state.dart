import 'package:Weather/data/models/hourly_weather_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_weather_state.freezed.dart';

@freezed
class HourlyWeatherState with _$HourlyWeatherState {
  factory HourlyWeatherState.initial() = _Iniital;
  factory HourlyWeatherState.loadingStarted() = _LoadingStarted;
  factory HourlyWeatherState.loadingSuccess(HourlyWeatherData success) =
      _loadingSuccess;
  factory HourlyWeatherState.loadingFailed() = _loadingFailed;
}
