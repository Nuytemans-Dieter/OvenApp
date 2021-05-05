import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oven_app/model/data/CelciusHistory.dart';

class CelciusGraph extends StatefulWidget {
  final CelciusHistory history;

  final List<FlSpot> allSpots = [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
    FlSpot(6, 8),
  ];

  CelciusGraph(this.history);

  @override
  State<StatefulWidget> createState() {
    return CelciusGraphState();
  }
}

class CelciusGraphState extends State<CelciusGraph> {
  final List<int> showIndexes = const [1, 3, 5];
  @override
  Widget build(BuildContext context) {


    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: widget.allSpots,
          isCurved: true,
          barWidth: 4,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            const Color(0xff12c2e9),
            const Color(0xfff64f59),
          ],
          colorStops: [
            0.1,
            0.9
          ]),
    ];

    return SizedBox(
      height: 200.0,
      child: LineChart(
        LineChartData(
          lineBarsData: lineBarsData
        ),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}
