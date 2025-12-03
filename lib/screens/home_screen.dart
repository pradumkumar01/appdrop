import 'package:AppDrop/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../core/models/page_model.dart';
import '../core/widget_factory/widget_factory.dart';

class HomeScreen extends StatefulWidget {
  final PageModel page;

  const HomeScreen(this.page, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _advancedDrawerController, // Important
      // Drawer content area
      drawer: drawer(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F3F7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'AppDrop',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  key: ValueKey<bool>(value.visible),
                  color: Colors.black87,
                );
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.black87),
            ),
          ],
        ),

        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.page.components.length,
          padding: const EdgeInsets.symmetric(),
          itemBuilder: (context, index) {
            final comp = widget.page.components[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: WidgetFactory.buildComponent(comp),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
