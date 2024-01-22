import 'package:Weather/data/models/daily_weather_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_weather_state.freezed.dart';

@freezed
class DailyWeatherState with _$DailyWeatherState {
  factory DailyWeatherState.initial() = _Iniital;
  factory DailyWeatherState.loadingStarted() = _LoadingStarted;
  factory DailyWeatherState.loadingSuccess(DailyWeatherData success) =
      _loadingSuccess;
  factory DailyWeatherState.loadingFailed() = _loadingFailed;
}
