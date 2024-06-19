enum Rx {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}

// https://www.antdv.com/components/grid-cn#api
Rx defaultRx(double width) {
  if (width < 576) return Rx.xs;
  if (width >= 576 && width < 768) return Rx.sm;
  if (width >= 768 && width < 992) return Rx.md;
  if (width >= 992 && width < 1200) return Rx.lg;
  if (width >= 1200 && width < 1600) return Rx.xl;
  return Rx.xxl;
}

Map<Rx, T> getRxObj<T>(Map<Rx, T> widths, T defaultValue) {
  // 定义一个按优先级排列的列表
  final List<Rx> priorityList = [Rx.xs, Rx.sm, Rx.md, Rx.lg, Rx.xl, Rx.xxl];

  // 初始化 obj 并设置默认值为 0
  Map<Rx, T> obj = {for (var rx in Rx.values) rx: defaultValue};

  // 按照优先级从高到低查找并设置值
  for (var rx in priorityList) {
    if (widths.containsKey(rx)) {
      obj[rx] = widths[rx] as T;
    } else {
      int index = priorityList.indexOf(rx);
      if (index > 0) {
        obj[rx] = obj[priorityList[index - 1]] as T;
      }
    }
  }

  return obj;
}

typedef Op<T> = T Function(Rx re);

extension RxT<T> on T {
  Op<T> get rx => (Rx re) => this;
}
