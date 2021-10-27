import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/components/charts/area_chart_widget.dart';
import 'package:flutter_semanas/app/models/result_model.dart';
import 'contrainst.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InitController extends Disposable {
  static const platform = MethodChannel('mobills.com.br/aldebaran');

  double valor = 1;
  bool progressivo = false;

  List<ResultModel> getYield() {
    List<ResultModel> resultado = [];

    for (var i = 1; i <= 52; i++) {
      var deposito = valor * (progressivo ? i : 1);
      var ultimoAcumulado =
          resultado.isNotEmpty ? resultado.last.acumulado ?? 0 : 0;
      resultado.add(
        ResultModel(
          semana: i,
          acumulado: ultimoAcumulado + deposito,
          deposito: deposito,
          juros: 0,
        ),
      );
    }

    return resultado;
  }

  List<ResultModel> getYieldJuros(double valJuros) {
    List<ResultModel> resultado = [];

    Map<int, double> acumuladoSemanal = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
    };

    int semana = 1;
    for (var i = 1; i <= 52; i++) {
      var deposito = valor * (progressivo ? i : 1);
      var valorSemana = acumuladoSemanal[semana] ?? 0;
      var juros = valorSemana * valJuros;
      var jurosSemana = valorSemana + juros.setPrecision(2);
      var ultimoAcumulado =
          resultado.isNotEmpty ? resultado.last.acumulado ?? 0 : 0;
      resultado.add(
        ResultModel(
          semana: i,
          acumuladoSemanal: jurosSemana + deposito,
          acumulado: ultimoAcumulado + juros + deposito,
          deposito: deposito,
          juros: juros,
        ),
      );

      acumuladoSemanal[semana] = jurosSemana + deposito;

      if (semana == 4) {
        semana = 1;
      } else {
        semana += 1;
      }
    }

    return resultado;
  }

  List<charts.Series<dynamic, num>> chartData() {
    var carteira = getYield();
    var poupanca = getYieldJuros(JUROS_POUPANCA);
    var cdb = getYieldJuros(JUROS_CDI);
    return [
      charts.Series<AreaChartData, int>(
        id: 'Carteira',
        colorFn: (_, __) => charts.Color.fromHex(code: "#4CB050"),
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: carteira
            .map<AreaChartData>((e) => AreaChartData(e.semana!, e.acumulado!))
            .toList(),
      ),
      charts.Series<AreaChartData, int>(
        id: 'Poupança',
        colorFn: (_, __) => charts.Color.fromHex(code: "#813DFB"),
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: poupanca
            .map<AreaChartData>((e) => AreaChartData(e.semana!, e.acumulado!))
            .toList(),
      ),
      charts.Series<AreaChartData, int>(
        id: 'CDB',
        colorFn: (_, __) => charts.Color.fromHex(code: "#ED8562"),
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: cdb
            .map<AreaChartData>((e) => AreaChartData(e.semana!, e.acumulado!))
            .toList(),
      ),
    ];
  }

  Future<void> setValue() async {
    valor = await platform.invokeMethod('getValue');
  }

  @override
  void dispose() {}
}

extension DoubleUtils on double {
  double setPrecision(int n) => double.parse(toStringAsFixed(n));
}
