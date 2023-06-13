import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;

  const MonthlySummary({
    super.key,
    required this.datasets,
    });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMapCalendar(
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.black,
        showColorTip: false,
        monthFontSize: 24,
        onClick:(p0) => {},
        size: 30,
        colorsets: const{
          1: Color.fromARGB(20, 160, 17, 190),
          2: Color.fromARGB(40, 160, 17, 190),
          3: Color.fromARGB(60, 160, 17, 190),
          4: Color.fromARGB(80, 160, 17, 190),
          5: Color.fromARGB(100, 160, 17, 190),
          6: Color.fromARGB(120, 160, 17, 190),
          7: Color.fromARGB(150, 160, 17, 190),
          8: Color.fromARGB(180, 160, 17, 190),
          9: Color.fromARGB(210, 160, 17, 190),
          10: Color.fromARGB(255, 160, 17, 190),
        }
      )
    );
  }
}