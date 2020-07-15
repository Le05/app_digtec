class Titles {
  String vencimentoAtualizado;
  String status;
  int numeroDocumento;
  String vencimento;
  String link;
  int id;
  String dataPagamento;
  int statusid;
  double valorCorrigido;
  double valor;
  String linhaDigitavel;
  bool pagarcartaodebito;
  bool pagarCartao;

  Titles(
      this.vencimentoAtualizado,
      this.status,
      this.numeroDocumento,
      this.vencimento,
      this.link,
      this.id,
      this.dataPagamento,
      this.statusid,
      this.valorCorrigido,
      this.valor,
      this.linhaDigitavel,
      this.pagarcartaodebito,
      this.pagarCartao);
}

List<Titles> fromJson(json) {
  List<Titles> titles = [];
  for (var u in json) {
    Titles titlesU = Titles(
        u["vencimento_atualizado"],
        u["status"],
        u["numero_documento"],
        u["vencimento"],
        u["link"],
        u["id"],
        u["data_pagamento"],
        u["statusid"],
        u["valorcorrigido"],
        u["valor"],
        u["linhadigitavel"],
        u["pagarcartaodebito"],
        u["pagarcartao"]);
    titles.add(titlesU);
  }
  return titles;
}
