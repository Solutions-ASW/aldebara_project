// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/components/charts/area_chart_widget.dart';
import 'package:flutter_semanas/app/controllers/init_controller.dart';

class InitView extends StatefulWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  final initController = Modular.get<InitController>();
  bool loading = true;

  @override
  void initState() {
    loading = true;
    WidgetsBinding.instance!.addPostFrameCallback((time) async {
      await initController.setValue();
      setState(() => loading = false);
    });
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
        title: const Text("indicadores"),
      ),
      backgroundColor: const Color(0xFFf5f6fb),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.all(16).copyWith(top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AreaChart(
                        initController.chartData(),
                        animate: true,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24.0,
                            horizontal: 16.0,
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    'Poupança:',
                                    style: TextStyle(
                                      color: Color(0xFF777777),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '4,375% ao ano.',
                                    style: TextStyle(color: Color(0xFF777777)),
                                  )
                                ],
                              ),
                              Text(
                                'Rende 70% da taxa selic (4,375%).',
                                style: TextStyle(color: Color(0xFF777777)),
                              ),
                              SizedBox(height: 12),
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    'CDB:',
                                    style: TextStyle(
                                      color: Color(0xFF777777),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '6,15% ao ano.',
                                    style: TextStyle(color: Color(0xFF777777)),
                                  )
                                ],
                              ),
                              Text(
                                'Rende 100% do CDI (6,15%).',
                                style: TextStyle(color: Color(0xFF777777)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
