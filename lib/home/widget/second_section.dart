import 'package:flutter/material.dart';
import 'package:flutter_admin_universal/home/model/sales_data.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// @author jd

class SecondSection extends StatefulWidget {
  @override
  State<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends State<SecondSection>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _dateSelectText;
  List<SalesData> listData;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    listData = <SalesData>[
      SalesData('浙江', 35),
      SalesData('江苏', 28),
      SalesData('上海', 34),
      SalesData('北京', 32),
      SalesData('南京', 40),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        height: 200,
        // margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            _topWidget(),
            const Divider(
              height: 1,
            ),
            Expanded(child: _contentWidget()),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          height: 30,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black87,
            labelStyle: TextStyle(fontSize: 12),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.blue,
            tabs: [
              Tab(
                text: '销售额',
              ),
              Tab(
                text: '访问量',
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size(1, 1),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  ),
                  child: Text(
                    '今日',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size(1, 1),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  ),
                  child: Text(
                    '本周',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size(1, 1),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  ),
                  child: Text(
                    '本月',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size(1, 1),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  ),
                  child: Text(
                    '全年',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showDateSelect();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withAlpha(100),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        Text(
                          _dateSelectText ?? '2018-01-01 2018-12-31',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.date_range_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDateSelect() async {
    DateTime start = DateTime.now();
    DateTime end = DateTime(
      2021,
      12,
      31,
    );
    DateTimeRange selectTimeRange = await showDateRangePicker(
      context: context,
      // locale: Locale('zh', 'CH'),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2022, 12),
      cancelText: '取消',
      confirmText: '确定',
      initialDateRange: DateTimeRange(start: start, end: end),
    );

    /// 此处时间需要格式化一下
    String time = selectTimeRange.toString();
    if (time != null && time.isNotEmpty) {
      DateTime startTime = selectTimeRange.start;
      DateTime endTime = selectTimeRange.end;
      DateFormat format = DateFormat('yyyy-MM-dd');
      _dateSelectText = '${format.format(startTime)} ${format.format(endTime)}';
      setState(() {});
    }
  }

  Widget _contentWidget() {
    return TabBarView(
      controller: _tabController,
      children: [
        Container(
          child: Center(child: _chartStyle1Widget()),
        ),
        Container(
          child: Center(child: Text('业余项目，不具备上线能力')),
        ),
      ],
    );
  }

  Widget _chartStyle1Widget() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      // title: ChartTitle(text: '热门搜索'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ColumnSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
          dataSource: listData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (sales, _) => sales.sales,
          width: 0.5,
          name: '男性',
        ),
        ColumnSeries<SalesData, String>(
          dataSource: listData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (sales, _) => sales.sales,
          width: 0.5,
          name: '女性',
        ),
      ],
    );
  }
}
