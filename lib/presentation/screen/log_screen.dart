import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/enum/timer_event.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';
import 'package:flutter_stopwatch_timetracking/application/widget/appbar/app_bar_tamplate.dart';
import 'package:flutter_stopwatch_timetracking/application/widget/sliver/sliver_body_rouner.dart';
import 'package:flutter_stopwatch_timetracking/di/di.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/presentation/bloc/log_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LogScreen extends StatelessWidget {
  static const routeName = '/logs';

  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _dateFormatter = DateFormat('dd.MM.yyyy hh:mm:ss');

    return MultiProvider(
      providers: [
        Provider<LogBloc>(
          create: (_) => getIt<LogBloc>(),
          dispose: (context, logBloc) {
            logBloc.dispose();
          },
        )
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Consumer<LogBloc>(
          builder: (context, logBloc, child) {
            return StreamBuilder<List<TimerLog>>(
              stream: logBloc.logStream,
              builder: (context, snapshop) {
                final List<TimerLog> logs = snapshop.data ?? [];

                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                  controller: logBloc.scrollController,
                  slivers: [
                    SliverAppBarTemplate(
                      title: const Text('Logs'),
                    ),
                    const SliverBodyRounder(),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(                        
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(                            
                              label: Text(
                                'Event',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Pause reason',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: logs.map((timerlog) {
                            return DataRow(cells: [
                              DataCell(
                                Text(_dateFormatter.format(timerlog.date)),
                              ),
                              DataCell(
                                Text(timerlog.event.convertToString()),
                              ),
                              DataCell(
                                Text(timerlog.pauseReason == null ? '-' : timerlog.pauseReason!.name),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
