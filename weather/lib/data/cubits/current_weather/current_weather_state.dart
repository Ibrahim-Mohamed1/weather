import 'package:Weather/data/models/current_weather_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_weather_state.freezed.dart';

@freezed
class CurrentWeatherState with _$CurrentWeatherState {
  factory CurrentWeatherState.initial() = _Iniital;
  factory CurrentWeatherState.loadingStarted() = _LoadingStarted;
  factory CurrentWeatherState.loadingSuccess(CurrentWeatherData success) =
      _loadingSuccess;
  factory CurrentWeatherState.loadingFailed() = _loadingFailed;
}
