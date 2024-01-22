import 'package:Weather/data/cubits/daily_weather/daily_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/remote_data_source.dart';

class DailyWeatherCubit extends Cubit<DailyWeatherState> {
  DailyWeatherCubit() : super(DailyWeatherState.initial());
  final WeatherApi weatherApi = WeatherApi();

  Future<void> fetchDailyWeather() async {
    emit(DailyWeatherState.loadingStarted());

    final response = await weatherApi.getDailyWeatherData();

    emit(DailyWeatherState.loadingSuccess(response));
  }
}
