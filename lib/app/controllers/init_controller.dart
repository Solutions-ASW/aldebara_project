import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/components/charts/area_chart_widget.dart';
import 'package:flutter_semanas/app/models/params_model.dart';
import 'package:flutter_semanas/app/models/result_model.dart';
import 'contrainst.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InitController extends Disposable {
  void getYieldByMonth(ParamsModel investiment) {
    investiment.investimentPeriod = 12;
    investiment.investimentType = INVESTMENT.poupanca;
    investiment.investmentValue = 10;

    double? percent = getPorcent[investiment.investimentType] ?? 0;

    Map<String, double> months = {
      "jan": 0,
      "fev": 0,
      "mar": 0,
      "abr": 0,
      "mai": 0,
      "jun": 0,
      "jul": 0,
      "ago": 0,
      "set": 0,
      "out": 0,
      "nov": 0,
      "dez": 0
    };

    double acumulado = investiment.investmentValue ?? 0;

    months.forEach((key, value) {
      acumulado += (percent * acumulado);
      months[key] = acumulado;
    });

    var teste = months;
  }

  List<ResultModel> getYieldByWeek() {
    ParamsModel? investiment = ParamsModel(
      investimentPeriod: 13,
      investimentType: INVESTMENT.poupanca,
      investmentValue: 10,
    );

    Map<int, double> weeks = {};
    int maxCount = investiment.investimentPeriod ?? 0;
    int count = 1;
    int countWeek = 0;

    double valorTotal = 0;
    double deposito = investiment.investmentValue ?? 0;
    double acumuladoSemana = 0;
    double percentagem = getPorcent[investiment.investimentType] ?? 0;
    double juros = 0;

    List<ResultModel> resultados = [];

    while (maxCount >= count) {
      for (var i = 0; i < 4; i++) {
        countWeek++;
        ResultModel resultModel = ResultModel();
        valorTotal += deposito + juros;
        resultModel.semana = countWeek;
        resultModel.acumulado = valorTotal;
        resultModel.acumuladoSemanal = acumuladoSemana;
        resultModel.juros = juros;
        resultModel.deposito = deposito;

        resultados.add(resultModel);
      }
      double? cal = resultados[countWeek - 4].deposito! +
          resultados[countWeek - 4].juros!;

      acumuladoSemana += cal;
      juros = acumuladoSemana * percentagem;

      count++;
    }

    return resultados;
  }

  List<ResultModel> getYieldByWeekProgressive() {
    ParamsModel? investiment = ParamsModel(
      investimentPeriod: 13,
      investimentType: INVESTMENT.poupanca,
      investmentValue: 10,
    );

    Map<int, double> weeks = {};
    int maxCount = investiment.investimentPeriod ?? 0;
    int count = 1;
    int countWeek = 0;

    double valorTotal = 0;
    double deposito = investiment.investmentValue ?? 0;
    double acumuladoSemana = 0;
    double percentagem = getPorcent[investiment.investimentType] ?? 0;
    double juros = 0;

    List<ResultModel> resultados = [];

    while (maxCount >= count) {
      for (var i = 0; i < 4; i++) {
        countWeek++;

        ResultModel resultModel = ResultModel();
        valorTotal += deposito + juros;
        resultModel.semana = countWeek;
        resultModel.acumulado = valorTotal;
        resultModel.acumuladoSemanal = acumuladoSemana;
        resultModel.juros = juros;
        resultModel.deposito = deposito;

        resultados.add(resultModel);

        if (countWeek > 3) {
          double? cal = resultados[countWeek - 4].deposito! +
              resultados[countWeek - 4].juros! +
              resultados[countWeek - 4].acumuladoSemanal!;

          acumuladoSemana = cal;
          juros = acumuladoSemana * percentagem;
        }

        deposito += 10;
      }

      count++;
    }

    return resultados;
  }

  List<charts.Series<dynamic, num>> chartData({
    required List<AreaChartData> money,
    required List<AreaChartData> popupanca,
    required List<AreaChartData> cdb,
  }) {
    return [
      charts.Series<AreaChartData, int>(
        id: 'Casteira',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: AreaChartData.mockDinheiro,
      ),
      charts.Series<AreaChartData, int>(
        id: 'Poupança',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: AreaChartData.mockPoupanca,
      ),
      charts.Series<AreaChartData, int>(
        id: 'CDB',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (AreaChartData balance, _) => balance.week,
        measureFn: (AreaChartData balance, _) => balance.value,
        data: AreaChartData.mockCDB,
      ),
    ];
  }

  @override
  void dispose() {}
}
