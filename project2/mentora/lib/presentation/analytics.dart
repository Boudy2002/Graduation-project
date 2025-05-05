import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentora_app/presentation/home.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String selectedTimeframe = 'All-time';
  final List<String> timeframes = [
    'Last Day',
    'Last Week',
    'Last Month',
    'All-time',
  ];

  String selectedActivityView = 'Month';
  final List<String> activityViews = ['Month', 'Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAnalyticsCards(),
            SizedBox(height: 20),
            _buildActivitySection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xFF1D24CA)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
      title: _buildTimeframeSelector(),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTimeframe,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items:
          timeframes.map((timeframe) {
            return DropdownMenuItem(
              value: timeframe,
              child: Text(
                timeframe,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedTimeframe = value!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildAnalyticsCards() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildCard('Av. Session Length', '2m 34s', _buildLineChart()),
        _buildCard('Knowledge Gain', '+34%', _buildLineChart()),
        _buildCard('Starting Knowledge', '64%', _buildLineChart()),
        _buildCard('Current Knowledge', '86%', _buildLineChart()),
      ],
    );
  }

  Widget _buildCard(String title, String value, Widget chart) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Expanded(child: chart),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 2.5),
              FlSpot(2, 2),
              FlSpot(3, 3.5),
              FlSpot(4, 3),
              FlSpot(5, 4.5),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: Color(0xFF1D24CA),
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: Color(0xFF1D24CA).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Activity',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedActivityView,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  items:
                  activityViews.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedActivityView = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildActivityChart(),
      ],
    );
  }

  Widget _buildActivityChart() {
    List<String> labels = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    List<double> monthlyData = [2, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];

    return Container(
      height: 220,
      padding: EdgeInsets.all(8),
      child:
      selectedActivityView == 'Year'
          ? LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      labels[value.toInt()],
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                reservedSize: 20,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            checkToShowHorizontalLine: (value) => value % 10 == 0,
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                12,
                    (index) => FlSpot(index.toDouble(), monthlyData[index]),
              ),
              isCurved: true,
              barWidth: 3,
              color: Color(0xFF1D24CA),
              belowBarData: BarAreaData(
                show: true,
                color: Color(0xFF1D24CA).withOpacity(0.3),
              ),
            ),
          ],
        ),
      )
          : BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      labels[(value.toInt()) - 1],
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                reservedSize: 20,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            checkToShowHorizontalLine: (value) => value % 10 == 0,
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(12, (index) {
            return BarChartGroupData(
              x: index + 1,
              barRods: [
                BarChartRodData(
                  toY: monthlyData[index],
                  color: Color(0xFF1D24CA),
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
