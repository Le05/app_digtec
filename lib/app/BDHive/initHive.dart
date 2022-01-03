import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:franet/app/app_bloc.dart';
import 'package:franet/app/models/ClassRunTimeVariables.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box box;
AppBloc appBloc = AppBloc();
Response response;
Future<Map> initHive({BuildContext context}) async {
    dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  cripto = "ZnJhbmV0N0s3NFAtTEJTQjMtWFlKWEEtRzZNUVM=";
  //String cor;
  //String corFonte;
  // tenta abrir, caso de erro, ele inicializa e tenta abrir denovo
  try {
    box = await Hive.openBox('Configs');
  } catch (e) {
    var tempDir = await getTemporaryDirectory();
    tempDirPath = tempDir.path;
    var link;
    var resposta = await getParams();
    if (resposta == null) {
      return {"error": "error"};
    }
    resposta = resposta[0];
    if (resposta["param_status"] != "1") {
      return {"error": "param_status"};
    }

    var respostaInfo = await buscarInfoPreCadastro();
    if (respostaInfo == null) {
      return {"error": "error"};
    }

    if (respostaInfo.runtimeType.toString() ==
        "_InternalLinkedHashMap<String, dynamic>")
      preCadastros = [respostaInfo];
    else
      preCadastros = respostaInfo;

    appBloc.initOneSignal(resposta["param_appidonesignal"]);
    cor = resposta["param_corapp"];
    corapp2 = resposta["param_corapp2"];
    corFonteS = resposta["param_corfonte"];

    cor = cor.replaceFirst("#", "");
    corapp2 = corapp2.replaceFirst("#", "");

    cor = "0xFF" + cor;
    corapp2 = "0xFF" + corapp2;

    corFonteS = corFonteS.replaceFirst("#", "");
    corFonteS = "0xFF" + corFonteS;
    /* cores das fontes */
    corFundoBackgroundExibir = resposta["cor_fundo_background_exibir"];
    String corFundoBackground2 =
        "0xFF" + resposta["cor_fundo_background"].replaceFirst("#", "");
    corFundoBackground = Color(int.parse(corFundoBackground2));

    corFundoLogoTipoExibir = resposta["cor_fundo_logotipo_exibir"];
    String corFundoLogoTipo2 =
        "0xFF" + resposta["cor_fundo_logotipo"].replaceFirst("#", "");
    corFundoLogoTipo = Color(int.parse(corFundoLogoTipo2));

    String corfontebuttonhome2 =
        "0xFF" + resposta["cor_fonte_button_home"].replaceFirst("#", "");
    corfontebuttonhome = Color(int.parse(corfontebuttonhome2));

    corfontehome = Color(
        int.parse("0xFF${resposta["cor_fonte_home"].replaceFirst("#", "")}"));
    /* fim da cores fundo*/

    if (e.message ==
        "You need to initialize Hive or provide a path to store the box.") {
      var deviceInfo = await appBloc.getAndroidOrIOS();
      Directory path = await getApplicationDocumentsDirectory();
      Hive.init(path.path);
      box = await Hive.openBox('Configs');
      box.put("plataforma", deviceInfo[1]);
      box.put("deviceID", deviceInfo[0]);
      box.put("token", token);
      box.put("key", key);
      box.put(
          "baseUrl", "https://www.appdoprovedor.com.br/_api/verificaws.php");
      box.put("contracts", null);
      box.put("param_corapp", resposta["param_corapp"]);
      box.put("param_corfonte", resposta["param_corfonte"]);
      box.put("param_senha", resposta["param_senha"]);
      box.put("param_senhapadrao", resposta["param_senhapadrao"]);
      box.put("param_propaganda",
          resposta["param_propagandas"]["param_propaganda"]);

      paramurlcontratoscm = resposta["param_urlcontratoscm"];
      paramurlcontatowhats = resposta["param_urlcontatowhats"];
      parammsgprecadastro = resposta["param_msgprecadastro"];
      paramsiteprovedor = resposta["param_urlsiteprovedor"];
      imagemFundoExibir = resposta["imagem_fundo_exibir"];
      imagemFundo = resposta["imagem_fundo"];
      paymentCardcredit = resposta["payment_cardcredit"];
      paramExibirPreCadastro = resposta["param_exibir_pre_cadastro"];
      paramExibirGraficoConsumo = resposta["param_exibir_grafico_consumo"];
      paramTemplate = int.parse(resposta["param_template"]);
      paramIconesCustom = resposta["param_icones_custom"];
      paramImageLogo = resposta["param_logotipo_dash"];
      paramIconesUse = resposta['param_icones_use'];
      paramInstagram = resposta["param_instagram"];
      paramFacebook = resposta["param_facebook"];
      imagemFundoExibir2 =
          int.parse(resposta["imagem_fundo_exibir_dois"].toString());
      imageFundo2 = resposta["imagem_fundo_dois"];
      paramUseTypeOcorrence =
          int.parse(resposta["param_usetypeocorrence"].toString());
      paramTypeOcorrence = resposta["param_typeocorrence"];

      paramUseindique = int.parse(resposta["param_useindique"]);
      paramUseindiqueimg = resposta["param_useindiqueimg"];
      paramUseindiqueurl = resposta["param_useindiqueurl"];

      telefones = [];
      telefones.add(resposta["param_telefones"]["param_telprincipal"]);
      telefones.add(resposta["param_telefones"]["param_telsecundario"]);
      telefones.add(resposta["param_telefones"]["param_telwhats"]);
      telefones.add(resposta["param_telefones"]["param_telwhats1"]);
      telefones.add(resposta["param_telefones"]["param_telwhats2"]);

      for (var i = 0; i < telefones.length; i++) {
        if (telefones[i] == null || telefones[i] == "") {
          telefones.remove(telefones[i]);
        }
      }

      if (resposta["param_logotipomarginright"] != "") {
        paramlogotipomarginright =
            double.parse(resposta["param_logotipomarginright"]);
      } else {
        paramlogotipomarginright = 0;
      }

      if (resposta["param_logotipomarginleft"] != "") {
        paramlogotipomarginleft =
            double.parse(resposta["param_logotipomarginleft"]);
      } else {
        paramlogotipomarginleft = 0;
      }

      box.put("param_propagandaposicao",
          resposta["param_propagandas"]["param_propagandaposicao"]);
      box.put("param_urltestevelocidade", resposta["param_urltestevelocidade"]);
      paramurltestevelocidade = resposta["param_urltestevelocidade"];
      box.put("param_propagandatitulo",
          resposta["param_propagandas"]["param_propagandatitulo"]);
      box.put("param_system", resposta["param_system"]);
      box.put("param_txtaberturaos", resposta["param_txtaberturaos"]);
      box.put("param_telprincipal",
          resposta["param_telefones"]["param_telprincipal"]);
      box.put("param_telsecundario",
          resposta["param_telefones"]["param_telsecundario"]);
      box.put("param_telwhats", resposta["param_telefones"]["param_telwhats"]);
      box.put("param_txtpromessapag", resposta["param_txtpromessapag"]);
      box.put("param_txtpromessapagok", resposta["param_txtpromessapagok"]);
      box.put("param_facebook", resposta["param_facebook"]);
      box.put("param_instagram", resposta["param_instagram"]);
      box.put("param_ocorrenciatipo", resposta["param_ocorrenciatipo"]);
      box.put("param_motivoos", resposta["param_motivoos"]);
      box.put("param_abreos", resposta["param_abreos"]);
      box.put("param_icones_custom", resposta["param_icones_custom"]);

      if (base64.encode(utf8.encode(key + token)) != cripto) token = cripto;

      if (resposta["param_icones_custom"] == "1") {
        box.put("param_ico_segundavia",
            resposta["param_icones"]["param_ico_segundavia"]);
        box.put(
            "param_ico_faturas", resposta["param_icones"]["param_ico_faturas"]);
        box.put("param_ico_promessapag",
            resposta["param_icones"]["param_ico_promessapag"]);
        box.put(
            "param_ico_suporte", resposta["param_icones"]["param_ico_suporte"]);
        box.put("param_ico_testedevelocidade",
            resposta["param_icones"]["param_ico_testedevelocidade"]);
        box.put("param_ico_notificacoes",
            resposta["param_icones"]["param_ico_notificacoes"]);
        box.put("param_ico_dicas", resposta["param_icones"]["param_ico_dicas"]);
        box.put("param_ico_facebook",
            resposta["param_icones"]["param_ico_facebook"]);
        box.put("param_ico_instagram",
            resposta["param_icones"]["param_ico_instagram"]);
        box.put("param_ico_graficoconsumo",
            resposta["param_icones"]["param_ico_graficoconsumo"]);
        box.put("param_ico_contratoscm",
            resposta["param_icones"]["param_ico_contratoscm"]);
        box.put("param_ico_contatowhats",
            resposta["param_icones"]["param_ico_contatowhats"]);
        box.put("param_ico_siteprovedor",
            resposta["param_icones"]["param_ico_siteprovedor"]);
      }

      if (box.containsKey("param_logotipo")) {
        link = box.get("param_logotipo");
        var linkParam = resposta["param_logotipo"];
        if (link != linkParam) {
          box.put("param_logotipo", resposta["param_logotipo"]);
          // await DefaultCacheManager().downloadFile(resposta["param_logotipo"]);
        }
      } else {
        box.put("param_logotipo", resposta["param_logotipo"]);
        // dio.download(urlPath, savePath)
        // await DefaultCacheManager().downloadFile(resposta["param_logotipo"]);
      }
    }
  }
  //cor = "0xFF0047AB";
  //corFonteS = "0xFF000000";
  Map retorno = {
    "box": box,
    "color": alterColor(color: int.parse(cor)),
    "colorFonte": alterColor(color: int.parse(corFonteS))
  };

  return retorno;
}

Future getParams() async {
  try {
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(
        "https://www.appdoprovedor.com.br/_api/read_app-new.php",
        data: {"key": key, "token": token});
    return response.data;
  } catch (e) {
    return null;
  }
}

Future buscarInfoPreCadastro() async {
  Response response;
  try {
    dio.clear();
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    response = await dio.post(
        "https://www.appdoprovedor.com.br/_api/read_precadastro.php",
        data: {"key": key, "token": token});
    return response.data;
  } catch (e) {
    return null;
  }
}

Future<Box> getHiveInstance() async {
  if (box != null && box.isOpen)
    return box;
  else {
    var boxInit = await initHive();
    return boxInit["box"];
  }
}

Future updateBaseUrl(String baseUrl) async {
  Box box = await getHiveInstance();
  box.put("baseUrl", baseUrl);
}

alterColor({var color}) {
  int _cPrimaryValue = color;
  MaterialColor primary = MaterialColor(
    _cPrimaryValue,
    <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(_cPrimaryValue),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    },
  );
  return primary;
}
