import 'package:flutter/material.dart';

import 'rx.dart';

typedef RxParserStrategy = Rx Function(double width);

typedef RxWidgetBuilder = Widget Function(BuildContext context, Rx type);

class WindowRespondBuilder extends StatelessWidget {
  final RxWidgetBuilder builder;

  const WindowRespondBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.sizeOf(context);

    // https://zhuanlan.zhihu.com/p/524716237
    RxParserStrategy? themeRx =
        Theme.of(context).extension<ReParserStrategyTheme>()?.parserStrategy;

    RxParserStrategy? strategy = themeRx ?? defaultRx;
    return builder(context, strategy(windowSize.width));
  }
}

@immutable
class ReParserStrategyTheme extends ThemeExtension<ReParserStrategyTheme> {
  const ReParserStrategyTheme({required this.parserStrategy});

  final RxParserStrategy parserStrategy;

  @override
  ReParserStrategyTheme copyWith({
    RxParserStrategy? parserStrategy,
  }) {
    return ReParserStrategyTheme(
      parserStrategy: parserStrategy ?? this.parserStrategy,
    );
  }

  @override
  ReParserStrategyTheme lerp(
      ThemeExtension<ReParserStrategyTheme>? other, double t) {
    return this;
  }
}
