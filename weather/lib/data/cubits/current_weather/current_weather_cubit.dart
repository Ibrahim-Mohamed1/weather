import 'package:Weather/data/cubits/current_weather/current_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/remote_data_source.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherState.initial());
  final WeatherApi weatherApi = WeatherApi();

  Future<void> fetchCurrentWeather() async {
    emit(CurrentWeatherState.loadingStarted());

    final response = await weatherApi.getCurrentWeatherData();

    emit(CurrentWeatherState.loadingSuccess(response));
  }
}
