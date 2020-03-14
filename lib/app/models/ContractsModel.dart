List<Contracts> contracts;

class Contracts {
  String status;
  String razaoSocial;
  double planoInternetValor;
  String cpfCnpj;
  int vencimento;
  int contrato;
  String planoInternet;
  String planoInternetId;

  Contracts(
      this.status,
      this.razaoSocial,
      this.planoInternetValor,
      this.cpfCnpj,
      this.vencimento,
      this.contrato,
      this.planoInternet,
      this.planoInternetId);
}

fromJson(json) {
  List<Contracts> contracts = [];
  for (var u in json) {
    Contracts contractsU = Contracts(
      u["status"],
      u["razaosocial"],
      u["planointernet_valor"],
      u["cpfcnpj"],
      u["vencimento"],
      u["contrato"],
      u["planointernet"],
      u["planointernet_id"]);
     contracts.add(contractsU);
  }
  return contracts;
}
