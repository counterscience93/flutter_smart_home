import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_final/core/model/user.dart';
import 'package:smart_home_final/core/view_model/widget/devices_model.dart';
import 'package:smart_home_final/ui/views/base_widget.dart';
import 'package:smart_home_final/core/constants.dart/route_path.dart';
import 'package:smart_home_final/ui/views/widget/device_list_item_view_widget.dart';

class Devices extends StatelessWidget {
  const Devices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return BaseWidget<DevicesModel>(
      model: DevicesModel(api: Provider.of(context)),
      onModelReady: (model) => model.getDevices(Provider.of<User>(context).id),
      builder: (context, model, child) => model.busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: model.devices.length,
              itemBuilder: (context, index) => DeviceListItem(
                device: model.devices[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.Device,
                    arguments: model.devices[index],
                  );
                },
              ),
            ),
    );
  }
}
