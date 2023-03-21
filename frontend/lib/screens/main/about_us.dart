import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tweet_feed/screens/main/drawer.dart';
import 'package:tweet_feed/screens/main/profile/widget_about_us_drawer/panel_widget.dart';
import '../../models/info.dart';


class AboutUsPage extends StatefulWidget {
  final panelController = PanelController();
  AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int index = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Team'),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 1),
          Expanded(
            child: SlidingUpPanel(
              maxHeight: 200,
              minHeight: 100,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              controller: widget.panelController,
              color: Colors.transparent,
              body: PageView(
                children: devInfo.map((devInfo) => Image.asset(devInfo.urlImage!, fit: BoxFit.fill)).toList(),
                onPageChanged: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
              ),
              panelBuilder: (ScrollController scrollController) => PanelWidget(
                onClickedPanel: widget.panelController.open, key: UniqueKey(),
                devInfo: devInfo[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
