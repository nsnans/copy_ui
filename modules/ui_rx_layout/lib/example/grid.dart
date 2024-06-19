import 'package:flutter/material.dart';
import 'package:ui_rx_layout/ui_rx_layout.dart';

class LayoutDemo6 extends StatelessWidget {
  const LayoutDemo6({super.key});

  @override
  Widget build(BuildContext context) {
    const Color color1 = Color(0xffd3dce6);
    const Color color2 = Color(0xffe5e9f2);
    return Column(
      children: RxAlign.values.map(
        (e) {
          return BRow(
            align: e,
            defaultPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            cols: [
              BCol(
                  defaultSpan: 6,
                  span: {},
                  child: const Box(
                    color: color1,
                    height: 20,
                  )),
              BCol(defaultSpan: 4, child: const Box(color: color2, height: 42)),
              BCol(defaultSpan: 8, child: const Box(color: color1, height: 52)),
              BCol(defaultSpan: 6, child: const Box(color: color2)),
            ],
          );
        },
      ).toList(),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;
  final String? text;
  final double height;

  const Box({super.key, required this.color, this.text, this.height = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: text != null ? Text(text!) : null,
    );
  }
}

class LayoutDemo1 extends StatelessWidget {
  const LayoutDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BRow(
          cols: [
            BCol(defaultSpan: 24, child: const Box(color: Color(0xff99a9bf)))
          ],
        ),
        const SizedBox(height: 12),
        BRow(
          cols: [
            BCol(defaultSpan: 12, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 12, child: const Box(color: Color(0xffe5e9f2))),
          ],
        ),
        const SizedBox(height: 12),
        BRow(
          cols: [
            BCol(defaultSpan: 8, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 8, child: const Box(color: Color(0xffe5e9f2))),
            BCol(defaultSpan: 8, child: const Box(color: Color(0xffd3dce6))),
          ],
        ),
        const SizedBox(height: 12),
        BRow(
          cols: [
            BCol(defaultSpan: 6, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 6, child: const Box(color: Color(0xffe5e9f2))),
            BCol(defaultSpan: 6, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 6, child: const Box(color: Color(0xffe5e9f2))),
          ],
        ),
      ],
    );
  }
}

class LayoutDemo2 extends StatelessWidget {
  const LayoutDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BRow(
          defaultGutter: 20,
          cols: [
            BCol(defaultSpan: 16, child: const Box(color: Color(0xff99a9bf))),
            BCol(defaultSpan: 8, child: const Box(color: Color(0xff99a9bf))),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        BRow(
          defaultGutter: 20,
          cols: [
            BCol(defaultSpan: 8, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 8, child: const Box(color: Color(0xffe5e9f2))),
            BCol(defaultSpan: 4, child: const Box(color: Color(0xffe5e9f2))),
            BCol(defaultSpan: 4, child: const Box(color: Color(0xffe5e9f2))),
          ],
        ),
        const SizedBox(height: 12),
        BRow(
          defaultGutter: 20,
          cols: [
            BCol(defaultSpan: 4, child: const Box(color: Color(0xffd3dce6))),
            BCol(defaultSpan: 16, child: const Box(color: Color(0xffe5e9f2))),
            BCol(defaultSpan: 4, child: const Box(color: Color(0xffd3dce6))),
          ],
        ),
      ],
    );
  }
}

class LayoutDemo3 extends StatelessWidget {
  const LayoutDemo3({super.key});

  @override
  Widget build(BuildContext context) {
    return BRow(
      defaultPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      defaultGutter: 20,
      cols: [
        BCol(
          span: {
            Rx.xs: 8,
            Rx.sm: 6,
            Rx.md: 4,
            Rx.lg: 3,
            Rx.xl: 1,
          },
          child: const Box(color: Color(0xffd3dce6)),
        ),
        BCol(
          span: {
            Rx.xs: 4,
            Rx.sm: 6,
            Rx.md: 8,
            Rx.lg: 9,
            Rx.xl: 11,
          },
          child: const Box(color: Color(0xffe5e9f2)),
        ),
        BCol(
          span: {
            Rx.xs: 12,
            Rx.sm: 6,
            Rx.md: 8,
            Rx.lg: 9,
            Rx.xl: 11,
          },
          child: const Box(color: Color(0xffd3dce6)),
        ),
        BCol(
          span: {
            Rx.xs: 0,
            Rx.sm: 6,
            Rx.md: 4,
            Rx.lg: 3,
            Rx.xl: 1,
          },
          child: const Box(color: Color(0xffd3dce6)),
        ),
      ],
    );
  }
}

class LayoutDemo5 extends StatelessWidget {
  const LayoutDemo5({super.key});

  @override
  Widget build(BuildContext context) {
    const Color color1 = Color(0xffd3dce6);
    const Color color2 = Color(0xffe5e9f2);
    return Column(
      children: RxJustify.values
          .map((e) => BRow(
                  justify: e,
                  defaultPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  cols: [
                    BCol(defaultSpan: 4, child: const Box(color: color1)),
                    BCol(defaultSpan: 2, child: const Box(color: color2)),
                    BCol(defaultSpan: 6, child: const Box(color: color1)),
                    BCol(defaultSpan: 6, child: const Box(color: color2)),
                  ]))
          .toList(),
    );
  }
}
