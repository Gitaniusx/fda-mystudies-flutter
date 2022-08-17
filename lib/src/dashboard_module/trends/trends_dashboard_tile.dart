import 'package:fda_mystudies_spec/study_datastore_service/get_study_dashboard.pbserver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/widget_util.dart';
import 'trends_view.dart';

class TrendsDashboardTile extends StatelessWidget {
  final List<GetStudyDashboardResponse_Dashboard_Chart> charts;

  const TrendsDashboardTile(this.charts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIOS = (isPlatformIos(context));
    return GestureDetector(
        onTap: () {
          push(context, TrendsView(charts));
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
                color: isIOS
                    ? CupertinoTheme.of(context).barBackgroundColor
                    : Theme.of(context).bottomAppBarColor),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trends', style: _titleStyle(context)),
                  Icon(
                      (isIOS
                          ? CupertinoIcons.right_chevron
                          : Icons.chevron_right_sharp),
                      size: 16,
                      color: isIOS ? CupertinoColors.inactiveGray : Colors.grey)
                ])));
  }

  TextStyle? _titleStyle(BuildContext context) {
    if (isPlatformIos(context)) {
      return CupertinoTheme.of(context)
          .textTheme
          .pickerTextStyle
          .apply(fontSizeFactor: 0.6, fontWeightDelta: 3);
    }
    return Theme.of(context)
        .textTheme
        .headline6
        ?.apply(fontSizeFactor: 0.7, fontWeightDelta: 3);
  }
}
