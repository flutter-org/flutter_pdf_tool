import 'dart:js';

import 'package:flutter_pdf_tool/pages/home.dart';
import 'package:flutter_pdf_tool/pages/pdfx.dart';
import 'package:flutter_pdf_tool/pages/sf_pdf.dart';
import 'package:go_router/go_router.dart';

class GoRouterUtil {
  static const String home = '/home';
  static const String pdfx = '/pdfx';
  static const String sf_pdf = '/sf_pdf';
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        name: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: pdfx,
        name: pdfx,
        builder: (context, state) => const PDFXPage(),
      ),
      GoRoute(
        path: sf_pdf,
        name: sf_pdf,
        builder: (context, state) => const SFPDFPage(),
      ),
    ],
  );
}
