enum INVESTMENT { poupanca, cdi, cdb, celic }

// ignore: constant_identifier_names
const Map<INVESTMENT, double> PERCENT = {
  INVESTMENT.poupanca: 0.003625,
  INVESTMENT.cdi: 0.2,
  INVESTMENT.cdb: 0.2,
  INVESTMENT.celic: 0.2,
};

Map<INVESTMENT, double> get getPorcent => PERCENT;
