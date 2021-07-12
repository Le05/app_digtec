List<Contracts> contracts = [];

class Contracts {
  String status;
  String razaoSocial;
  double planoInternetValor;
  String cpfCnpj;
  int vencimento;
  String planotv;
  int contrato;
  String planoInternet;
  List emails;
  String planomultimidiaId;
  String planovoipId;
  String planomultimidia;
  String planovoip;
  String planotvId;
  String planoInternetId;

  Contracts(
      this.status,
      this.razaoSocial,
      this.planoInternetValor,
      this.cpfCnpj,
      this.vencimento,
      this.planotv,
      this.contrato,
      this.planoInternet,
      this.emails,
      this.planomultimidiaId,
      this.planovoipId,
      this.planomultimidia,
      this.planovoip,
      this.planotvId,
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
      u["planotv"],
      u["contrato"],
      u["planointernet"],
      u["emails"],
      u["planomultimidia_id"],
      u["planovoip_id"],
      u["planomultimidia"],
      u["planovoip"],
      u["planotv_id"],
      u["planointernet_id"]);
     contracts.add(contractsU);
  }
  return contracts;
}
