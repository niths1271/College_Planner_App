import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'line_chart_data.dart';
import '../pages/overviewScreen.dart';

class LineChartContent extends StatelessWidget {
  LineChartContent({required this.lineChartBarData});
  List<LineChartBarData> lineChartBarData;
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Color(0xff4670db),
        minX: 1,
        minY: 0,
        maxX: 7,
        maxY: 4,
        lineBarsData: lineChartBarData,
        borderData:
            FlBorderData(border: Border.all(color: Colors.white, width: 0.5)),
        gridData: FlGridData(
          drawHorizontalLine: false,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'M';
                case 2:
                  return 'T';
                case 3:
                  return 'W';
                case 4:
                  return 'T';
                case 5:
                  return 'F';
                case 6:
                  return 'S';
                case 7:
                  return 'Su';
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            interval: 1,
            showTitles: true,
            getTextStyles: (context, value) => TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            getTitles: (value) {
              if (value.toInt() == 0)
                return '';
              else
                return value.toInt().toString();
            },
          ),
          rightTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
    );
  }
}
