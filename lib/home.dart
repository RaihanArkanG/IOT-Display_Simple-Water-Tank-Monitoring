import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'color.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController totalCapacityController;
  late TextEditingController currentLitersController;
  double percentage = 0.0;
  String selectedOption = 'Option 1';
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  int totalCapacity = 5000;
  int currentLiters = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.backgroundColor,
                title: buildAppBarTitle(),
                bottom: buildAppBarBottom(),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconButton(Icons.settings, () {}),
        Text(
          'BlueWater.co',
          style: TextStyle(
            fontSize: 20.0,
            color: AppColors.textColor,
          ),
        ),
        buildIconButton(Icons.notifications, () {}),
      ],
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      color: AppColors.primaryColor,
      onPressed: onPressed,
    );
  }

  PreferredSizeWidget buildAppBarBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDivider(),
            SizedBox(height: 2),
            buildLocationDropdown(),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: AppColors.outlineColor,
    );
  }

  Widget buildLocationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText('Your Location', fontSize: 16.0, color: AppColors.textColor),
        Container(
          width: double.infinity,
          child: buildDropdownButton(
            value: selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            items: ['Option 1', 'Option 2', 'Option 3']
                .map<DropdownMenuItem<String>>(
                  (String value) {
                return buildDropdownMenuItem(value);
              },
            )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildText(String text, {
    double fontSize = 14.0,
    Color color = AppColors.textColor,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }

  Widget buildDropdownButton({
    required String? value,
    required ValueChanged<String?> onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      items: items,
      elevation: 4,
      iconSize: 36,
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        buildText(
          'Overall Status Tank',
          fontSize: 16.0,
          color: AppColors.textColor,
        ),
        buildCircularPercentIndicator(),
      ],
    );
  }

  Widget buildCircularPercentIndicator() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 10000,
              radius: 150,
              lineWidth: 20,
              percent: percentage,
              progressColor: AppColors.primaryColor,
              backgroundColor: AppColors.accentColor,
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildText(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    fontSize: 30,
                    color: AppColors.accentColor,
                  ),
                  buildText(
                    '$currentLiters L',
                    fontSize: 20,
                    color: AppColors.accentColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Adjust the spacing as needed
            buildText(
              'Monitoring',
              fontSize: 18,
              color: AppColors.textColor,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: AppColors.textColor2,
                        size: 24,
                      ),
                      SizedBox(width: 8.0),
                      buildText(
                        'Temperature: 25°C',
                        fontSize: 18,
                        color: AppColors.textColor2,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.opacity,
                        color: AppColors.textColor2,
                        size: 24,
                      ),
                      SizedBox(width: 8.0),
                      buildText(
                        'Turbidity: 10 NTU',
                        fontSize: 18,
                        color: AppColors.textColor2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}