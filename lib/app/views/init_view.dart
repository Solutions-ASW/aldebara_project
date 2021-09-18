import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(
        toolbarHeight: 56.0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: "MavenPro",
          fontWeight: FontWeight.w600,
          fontSize: 21.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black38,
          size: 28.0,
        ),
        elevation: 0.2,
        backgroundColor: const Color(0xFFf5f6fb),
        automaticallyImplyLeading: false,
        leading: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => SystemNavigator.pop(),
          child: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: const Text("moto nova"),
      ),
      backgroundColor: const Color(0xFFf5f6fb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: AreaChart(
                initController.chartData(money: [], popupanca: [], cdb: []),
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
