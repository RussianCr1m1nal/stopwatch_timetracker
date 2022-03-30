import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';

const kExpandedSliverAppBarHeight = 184.0;

class SliverAppBarTemplate extends SliverAppBar {
  SliverAppBarTemplate({
    Key? key,
    Widget? leading,
    bool? automaticallyImplyLeading,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? shadowColor,
    bool? forceElevated,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool? primary,
    bool? centerTitle,
    bool? excludeHeaderSemantics,
    double? titleSpacing,
    double? collapsedHeight,
    bool? floating,
    bool? pinned,
    ShapeBorder? shape,
    bool? snap,
    bool? stretch,
    double? stretchTriggerOffset,
    AsyncCallback? onStretchTrigger,
    double? toolbarHeight,
    double? leadingWidth,
    double? expandedHeight,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) : super(
          key: key,
          automaticallyImplyLeading: automaticallyImplyLeading ?? false,
          flexibleSpace: flexibleSpace ??
              FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: AppBar(
                  backgroundColor: AppColors.appBarBackgroundColor,
                  leading: leading,
                  title: title,
                  titleSpacing: titleSpacing ?? 0.0,
                  actions: actions,
                ),
              ),
          bottom: bottom,
          elevation: elevation ?? 0,
          shadowColor: shadowColor,
          forceElevated: forceElevated ?? false,
          backgroundColor: backgroundColor ?? AppColors.appBarBackgroundColor,
          foregroundColor: foregroundColor,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          primary: primary ?? true,
          centerTitle: centerTitle,
          excludeHeaderSemantics: excludeHeaderSemantics ?? false,
          titleSpacing: titleSpacing ?? 0.0,
          collapsedHeight: collapsedHeight,
          expandedHeight: expandedHeight ?? kToolbarHeight,
          floating: floating ?? true,
          pinned: pinned ?? false,
          snap: snap ?? false,
          stretch: stretch ?? false,
          stretchTriggerOffset: stretchTriggerOffset ?? 100.0,
          onStretchTrigger: onStretchTrigger,
          shape: shape,
          toolbarHeight: toolbarHeight ?? 0,
          leadingWidth: leadingWidth,
          toolbarTextStyle: toolbarTextStyle,
          titleTextStyle: titleTextStyle,
          systemOverlayStyle: systemOverlayStyle,
        );
}
