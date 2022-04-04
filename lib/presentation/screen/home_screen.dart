import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/enum/pause_reason.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';
import 'package:flutter_stopwatch_timetracking/application/widget/appbar/app_bar_tamplate.dart';
import 'package:flutter_stopwatch_timetracking/application/widget/sliver/sliver_body_rouner.dart';
import 'package:flutter_stopwatch_timetracking/di/di.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/stopwatch.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/wrok_timer.dart';
import 'package:flutter_stopwatch_timetracking/presentation/bloc/home_bloc.dart';
import 'package:flutter_stopwatch_timetracking/presentation/icons/custom_icons.dart';
import 'package:flutter_stopwatch_timetracking/presentation/widget/pause_card.dart';
import 'package:flutter_stopwatch_timetracking/presentation/widget/timer_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentDate = DateTime.now();
    final _dateFormatter = DateFormat('dd.MM.yyyy');
    final String _displayDate = _dateFormatter.format(_currentDate);

    return MultiProvider(
      providers: [
        Provider<HomeBloc>(
          create: (_) => getIt<HomeBloc>(),
          dispose: (context, homeBloc) {
            homeBloc.dispose();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) {
            return StreamBuilder<WorkTimer>(
              stream: homeBloc.timerStream,
              builder: (context, snapshot) {
                final int currentTime = snapshot.data == null ? 0 : snapshot.data!.currentTime;
                final int workTime = snapshot.data == null ? 0 : snapshot.data!.workTime;
                final int pauseTime = snapshot.data == null ? 0 : snapshot.data!.pauseTime;

                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                  controller: homeBloc.scrollController,
                  slivers: [
                    SliverAppBarTemplate(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          _displayDate,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'AvenirNext',
                          ),
                        ),
                      ),
                      actions: const [
                        Padding(
                          padding: EdgeInsets.only(right: 18),
                          child: Icon(
                            CustomIcons.profile,
                            size: 27,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SliverBodyRounder(),
                    homeBloc.currentTimer.isRunning
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: Center(
                                  child: Text(
                                Stopwatch.displayTime(currentTime),
                                style: TextStyle(
                                    fontFamily: 'AvenirNext',
                                    fontSize: 70,
                                    letterSpacing: 1.25,
                                    color: homeBloc.pauseTimer.isRunning
                                        ? AppColors.pauseTimeColor
                                        : AppColors.primaryColor),
                              )),
                            ),
                          )
                        : const SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeBloc.currentTimer.isRunning
                                ? Center(
                                    child: Text(
                                      Stopwatch.displayTime(workTime),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.paleGreen,
                                        fontFamily: 'AvenirNext',
                                      ),
                                    ),
                                  )
                                : Container(),
                            homeBloc.currentTimer.isRunning
                                ? Center(
                                    child: Text(
                                      Stopwatch.displayTime(pauseTime),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.pauseTimeColor,
                                        fontFamily: 'AvenirNext',
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: homeBloc.currentTimer.isRunning ? 17 : 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimerButton(
                              disabled: homeBloc.workTimer.isRunning,
                              onPressed: homeBloc.start,
                              color: AppColors.primaryColor,
                              disabledColor: AppColors.disabledButton,
                              icon: const Icon(
                                CustomIcons.start,
                                color: Colors.white,
                                size: 28,
                              ),
                              text: 'Начать \nПУЛ',
                            ),
                            !homeBloc.currentTimer.isRunning
                                ? TimerButton(
                                    disabled: false,
                                    onPressed: homeBloc.start,
                                    color: AppColors.primaryColor,
                                    icon: const Icon(
                                      CustomIcons.start,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    text: 'Начать ремонт',
                                  )
                                : TimerButton(
                                    disabled: false,
                                    onPressed: homeBloc.stop,
                                    color: AppColors.stopButtonColor,
                                    icon: const Icon(
                                      CustomIcons.stop,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    text: 'Закрыть смену'),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 28, left: 24, bottom: 12),
                        child: Text(
                          'Остановка работ',
                          style: TextStyle(
                            color: AppColors.mainFontColor,
                            fontSize: 14,
                            letterSpacing: 0.25,
                            fontFamily: 'AvenirNext',
                          ),
                        ),
                      ),
                    ),
                    homeBloc.currentTimer.isRunning
                        ? StreamBuilder<PauseReason?>(
                            stream: homeBloc.pauseReasonStream,
                            builder: (context, snapshot) {
                              return SliverToBoxAdapter(
                                child: Column(
                                  children: pauseList(homeBloc, snapshot.data),
                                ),
                              );
                            })
                        : const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text(
                                'Смена не начата - остановка невозможна',
                                style: TextStyle(
                                  color: AppColors.disabledColor,
                                  fontSize: 14,
                                  fontFamily: 'AvenirNext',
                                ),
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

  List<Widget> pauseList(HomeBloc homeBloc, PauseReason? currentReason) {
    final bool disabled = currentReason != null;

    return [
      PauseCard(
        disabled: disabled,
        inFocus: currentReason == PauseReason.breaking,
        onTap: () {
          homeBloc.pause(PauseReason.breaking);
        },
        title: 'Поломка',
        subtittle: 'Подозрение на поломку, дигностика поломки',
      ),
      PauseCard(
        disabled: disabled,
        inFocus: currentReason == PauseReason.waiting,
        onTap: () {
          homeBloc.pause(PauseReason.waiting);
        },
        title: 'Ожидание ТМЦ',
        subtittle: 'Ожидание подвоза воды, СЗР',
      ),
      PauseCard(
        disabled: disabled,
        inFocus: currentReason == PauseReason.refueling,
        onTap: () {
          homeBloc.pause(PauseReason.refueling);
        },
        title: 'Заправка',
        subtittle: 'Ожидание топливозаправщика, заправка техники топливом',
      ),
      PauseCard(
        disabled: disabled,
        inFocus: currentReason == PauseReason.technicalBreak,
        onTap: () {
          homeBloc.pause(PauseReason.technicalBreak);
        },
        title: 'Технический перерыв',
        subtittle: 'Туалет, обед',
      ),
      PauseCard(
        disabled: disabled,
        inFocus: currentReason == PauseReason.weather,
        onTap: () {
          homeBloc.pause(PauseReason.weather);
        },
        title: 'Погода',
        subtittle: 'Остановка в связи с погодными условиями',
      ),
    ];
  }
}
