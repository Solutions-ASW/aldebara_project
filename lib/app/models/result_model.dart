class ResultModel {
  int? semana;
  double? valorAtual;
  double? deposito;
  double? acumuladoSemanal;
  double? juros;
  double? acumulado;

  ResultModel(
      {this.semana,
      this.valorAtual,
      this.deposito,
      this.acumuladoSemanal,
      this.juros,
      this.acumulado});

  ResultModel.fromJson(Map<String, dynamic> json) {
    semana = json['semana'];
    valorAtual = json['valor_atual'];
    deposito = json['deposito'];
    acumuladoSemanal = json['acumulado_semanal'];
    juros = json['juros'];
    acumulado = json['acumulado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semana'] = this.semana;
    data['valor_atual'] = this.valorAtual;
    data['deposito'] = this.deposito;
    data['acumulado_semanal'] = this.acumuladoSemanal;
    data['juros'] = this.juros;
    data['acumulado'] = this.acumulado;
    return data;
  }
}
