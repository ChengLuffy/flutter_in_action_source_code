import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/routes/datatable.dart';

class TableRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TableRouteState();
}

class _TableRouteState extends State<TableRoute> {
  bool _sort = true;
  var _dataSource = <Map>[];

  @override
  void initState() {
    _dataSource.add({"id": "1", "price": "28.5"});
    _dataSource.add({"id": "2", "price": "27.5"});
    super.initState();
  }

  void _onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        _dataSource.sort((a, b) => a['id'].compareTo(b['id']));
      } else {
        _dataSource.sort((a, b) => b['id'].compareTo(a['id']));
      }
    }
  }

  List<Padding> _addPadding(List<String> list) {
    return list
        .map((e) => Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(e),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Table(
          border: TableBorder.all(color: Colors.grey[400]!),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: _addPadding(["姓名", "性别", "备注"])),
            TableRow(children: _addPadding(["张三", "男", "我和李四不是朋友" * 6])),
            TableRow(children: _addPadding(["李四", "男", "不予置评"]))
          ],
        ),
        Container(
          height: 18,
        ),
        Text("👇点击可以排序"),
        DataTable(
          sortColumnIndex: 0,
          sortAscending: _sort,
          rows: _dataSource
              .map((e) => DataRow(
                  cells: [DataCell(Text(e["id"])), DataCell(Text(e["price"]))]))
              .toList(),
          columns: <DataColumn>[
            DataColumn(
                label: Text("Id"),
                numeric: true,
                onSort: (columnIndex, ascending) {
                  setState(() {
                    _sort = !_sort;
                  });
                  _onSortColum(columnIndex, ascending);
                }),
            DataColumn(label: Text("价格￥"), numeric: true)
          ],
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DataTableRoute();
              }));
            },
            child: Text("PaginatedDataTable"))
      ],
    );
  }
}
