import 'package:flutter/material.dart';
import 'package:flutter_pdf_tool/models/module_model.dart';
import 'package:flutter_pdf_tool/packages/go_router_util.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ModuleModel> _modules = [
    ModuleModel(
      title: 'pdfx',
      route: GoRouterUtil.pdfx,
    ),
    ModuleModel(
      title: 'sf_pdf',
      route: GoRouterUtil.sf_pdf,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: _modules.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          ModuleModel moduleModel = _modules[index];
          return ListTile(
            title: Text(moduleModel.title),
            onTap: () {
              context.pushNamed(moduleModel.route);
            },
          );
        },
      ),
    );
  }
}
