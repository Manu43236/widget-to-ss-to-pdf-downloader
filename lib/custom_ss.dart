import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;

class CustomSS {
  

  Future<void> createAndDownloadPdf(List<Widget> widgets) async {
    final ScreenshotController screenshotController = ScreenshotController();

    // List to hold the captured images
    List<Uint8List> images = [];

    // Capture screenshots
    for (Widget widget in widgets) {
      Uint8List? image = await screenshotController.captureFromWidget(widget);
      if (image != null) {
        images.add(image);
      }
    }

    // Create PDF document
    final pdf = pw.Document();

    // Add each image as a separate page in the PDF
    for (Uint8List image in images) {
      final pdfImage = pw.MemoryImage(image);
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
        pageFormat: PdfPageFormat.a4,
      ));
    }

    // Save the PDF as a Uint8List
    final pdfBytes = await pdf.save();

    // Create a blob from the PDF bytes
    final blob = html.Blob([pdfBytes], 'application/pdf');

    // Create a link element
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '${DateTime.timestamp()}.pdf')
      ..click();

    // Revoke the object URL to free memory
    html.Url.revokeObjectUrl(url);
  }
}