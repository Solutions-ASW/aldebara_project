import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_semanas/app/models/params_model.dart';
import 'package:flutter_semanas/app/models/result_model.dart';
import 'contrainst.dart';

class InitController extends Disposable {
  void getYieldByMonth(ParamsModel investiment) {
    investiment.investimentPeriod = 12;
    investiment.investimentType = INVESTMENT.poupanca;
    investiment.investmentValue = 10;

    double? porcent = getPorcent[investiment.investimentType] ?? 0;

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
      acumulado += (porcent * acumulado);
      months[key] = acumulado;
    });

    var teste = months;
  }

  void getYieldByWeek() {
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
    double porcentagem = getPorcent[investiment.investimentType] ?? 0;
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
      juros = acumuladoSemana * porcentagem;

      count++;
    }

    var teste = resultados;
  }

  void getYieldByWeekProgressive() {
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
    double porcentagem = getPorcent[investiment.investimentType] ?? 0;
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
          juros = acumuladoSemana * porcentagem;
        }

        deposito += 10;
      }

      count++;
    }

    var teste = resultados;
  }

  @override
  void dispose() {}
}
