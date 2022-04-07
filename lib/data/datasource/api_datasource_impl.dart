import 'package:flutter_stopwatch_timetracking/data/datasource/api_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ApiDataSource)
class ApiDataSourceImpl extends ApiDataSource {
  final dummyList = [
    {'id' : 1, 'name': 'Поломка', 'discription': 'подозрение на поломку, диагностика поломки'},
    {'id' : 2, 'name': 'Ожидание ТМЦ', 'discription': 'ожидание подвоза воды, СЗР'},
    {'id' : 3, 'name': 'Заправка', 'discription': 'ожидание топливозаправщика, заправка техники топливом'},
    {'id' : 4, 'name': 'Технический перерыв', 'discription': 'туалет, обед'},
    {'id' : 5, 'name': 'Погода', 'discription': 'остановка в связи с погодными условиями'},
  ];

  @override
  Future<List<Map<String, dynamic>>> getPauseReasons() async {
    return dummyList;
  }
}
