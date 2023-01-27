import 'package:flutter/material.dart';
import '../../../../models/dev_info.dart';
import 'panel_header_widget.dart';

class PanelWidget extends StatelessWidget {
  final User devInfo;
  final VoidCallback onClickedPanel;

  const PanelWidget({
    required this.devInfo,
    required this.onClickedPanel,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.transparent,
              ),
              child: buildProfile(),
            ),
          )
        ],
      );

  Widget buildProfile() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClickedPanel,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              PanelHeaderWidget(
                key: UniqueKey(), user: devInfo, 
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
}
