import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/components/charts/area_chart_widget.dart';
import 'package:flutter_semanas/app/controllers/init_controller.dart';
import 'package:flutter_semanas/app/models/params_model.dart';

class InitView extends StatefulWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  final initController = Modular.get<InitController>();

  @override
  void initState() {
    initController.getYieldByMonth(ParamsModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f6fb),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: AreaChart(
              initController.chartData(money: [], popupanca: [], cdb: []),
              animate: true,
            ),
          )
        ],
      ),
    );
  }
}
