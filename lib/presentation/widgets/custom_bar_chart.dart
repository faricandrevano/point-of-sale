import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final style =
                    bodyM.copyWith(color: neutral50, fontWeight: medium);
                Widget text;
                switch (value.toInt()) {
                  case 1:
                    text = Text('Jan', style: style);
                    break;
                  case 2:
                    text = Text('Feb', style: style);
                    break;
                  case 3:
                    text = Text('Mar', style: style);
                    break;
                  case 4:
                    text = Text('Apr', style: style);
                    break;
                  case 5:
                    text = Text('Mei', style: style);
                    break;
                  case 6:
                    text = Text('Jun', style: style);
                    break;
                  default:
                    text = Text('', style: style);
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
          // drawHorizontalLine: true,
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
                toY: 2,
                width: 40,
                borderRadius: BorderRadius.circular(0),
                color: const Color.fromARGB(255, 236, 236, 236),
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
