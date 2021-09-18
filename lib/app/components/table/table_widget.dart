import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/controllers/init_controller.dart';
import 'package:flutter_semanas/app/models/result_model.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final initController = Modular.get<InitController>();

  List<ResultModel> resultYield = [];

  @override
  void initState() {
    resultYield = initController.getYieldByWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      height: 300,
      child: ListView.builder(
        itemCount: resultYield.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semana: ${resultYield[index].semana.toString()}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202021),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Investimento: \$ ${resultYield[index].deposito!.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF777777),
                          ),
                        ),
                        Text(
                          "Rendimento: \$ ${resultYield[index].juros!.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Acumulado",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF777777),
                          ),
                        ),
                        Text(
                          "\$ ${resultYield[index].acumulado!.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CB050),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
