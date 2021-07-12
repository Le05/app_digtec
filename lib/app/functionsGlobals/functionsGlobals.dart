import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:path_provider/path_provider.dart';

String path;

class FunctinsGlobals {
  abrirPDF(String url) async {
    // baixar o pdf e salvar no local e abrir o mesmo
    Directory tempDir = await getTemporaryDirectory();
    String tempPath =
        tempDir.path + "/arquivos/${DateTime.now().microsecondsSinceEpoch}.pdf";
    await dio.download(url, tempPath);
    path = tempPath;
    return await PDFDocument.fromFile(File(tempPath));
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
        return Colors.white;
        break;
      case "SUSPENSO":
        return Colors.yellow;
      case "CANCELADO":
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
