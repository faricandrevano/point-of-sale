import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 1:
                    text = const Text('Januari', style: style);
                    break;
                  case 2:
                    text = const Text('Febuari', style: style);
                    break;
                  case 3:
                    text = const Text('Maret', style: style);
                    break;
                  case 4:
                    text = const Text('April', style: style);
                    break;
                  case 5:
                    text = const Text('Mei', style: style);
                    break;
                  case 6:
                    text = const Text('Juni', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        maxY: 10,
        barGroups: [
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 3,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 7,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 2,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 5,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 4,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
          BarChartGroupData(
            x: 6,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 8,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xff3D4C66),
              ),
            ],
          ),
        ],
      ),
      swapAnimationCurve: Curves.linear,
      swapAnimationDuration: const Duration(milliseconds: 150),
    );
  }
}
