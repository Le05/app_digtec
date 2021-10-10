import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:path_provider/path_provider.dart';

String path;

class FunctinsGlobals {
  abrirPDF(String url) async {
    Response retorno = await dio.post("https://www.appdoprovedor.com.br/_api/consultaurl.php",data: {"link":url});
    url = retorno.data["link"];

    // baixar o pdf e salvar no local e abrir o mesmo
    Directory tempDir = await getTemporaryDirectory();
    String tempPath =
        tempDir.path + "/arquivos/${DateTime.now().microsecondsSinceEpoch}.pdf";
    await dio.download(url, tempPath);
    path = tempPath;
    PDFDocument doc = await PDFDocument.fromFile(File(tempPath));
    doc.preloadPages();
    if(doc.count == 0){
       return throw DioErrorType.other;
    }
    return doc;
  }

  getPrimeiroUltimoNome(String nome) {
    List splitNome = nome.split(" ");
    if (splitNome.length > 1) {
      return splitNome.first + " " + splitNome.last;
    } else {
      return nome;
    }
  }

  retornaCorStatusServico(String status) {
    switch (status.trim().toUpperCase()) {
      case "ATIVO":
        return Colors.green[800];
        break;
      case "ATIVO V. REDUZIDA":
        return Colors.yellow[600];
      case "SUSPENSO":
        return Colors.orange;
      case "CANCELADO":
        return Colors.red;
      case "INATIVO":
        return Colors.black;
      default:
        return Colors.green[800];
    }
  }

  limparTelefonesMascara(String telefone){
    telefone = telefone.replaceAll("(", "");
    telefone = telefone.replaceAll(")", "");
    telefone = telefone.replaceAll(" ", "");
    telefone = telefone.replaceAll("-", "");
    return telefone;
  }
}
