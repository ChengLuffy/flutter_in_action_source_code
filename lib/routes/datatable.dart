import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class DataTableRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataTableRouteState();
}

class _DataTableRouteState extends State<DataTableRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTool.initBar("DataTableSource"),
      body: _generateBody(),
    );
  }

  /// 构造表头
  List<DataColumn> _generateColumns() {
    final columnsTitle = ["商品名", "价格", "库存", "类型"];
    return columnsTitle
        .map((e) => DataColumn(
            label: Text(e),
            onSort: (sortColumnIndex, sortAscending) {
              _onSortColumn(sortColumnIndex, sortAscending);
            }))
        .toList();
  }

  var _dataTableSource = _MyDataTableSource();
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _rowsPerPage = 5;

  /// 排序方法
  void _onSortColumn(int columnIndex, bool ascending) {
    switch (columnIndex) {
      case 0:
        _dataTableSource._sort((good) => good.name, ascending);
        break;
      case 1:
        _dataTableSource._sort((good) => good.number, ascending);
        break;
      case 2:
        _dataTableSource._sort((good) => good.type, ascending);
        break;
      case 3:
        _dataTableSource._sort((good) => good.price, ascending);
        break;
    }
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  /// 构造 body
  Widget _generateBody() {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: _generateColumns(),
        source: _dataTableSource,
        sortAscending: _sortAscending,
        sortColumnIndex: _sortColumnIndex,
        initialFirstRowIndex: 0,
        showCheckboxColumn: false,
        rowsPerPage: _rowsPerPage,
        onSelectAll: _dataTableSource._selectAll,
        header: Text('商品库存'),
        availableRowsPerPage: [5, 10],
        onRowsPerPageChanged: (value) {
          setState(() {
            _rowsPerPage = value!;
          });
        },
      ),
    );
  }
}

class _Good {
  final String name;
  final int number;
  final String type;
  final double price;
  bool selected = false; //默认为未选中

  List<DataCell> generateCell() {
    return [
      DataCell(Text(this.name)),
      DataCell(Text(this.number.toString())),
      DataCell(Text(this.type)),
      DataCell(Text("${this.price}"))
    ];
  }

  _Good(
    this.name,
    this.number,
    this.type,
    this.price,
  );
}

class _MyDataTableSource extends DataTableSource {
  int _currentSelectedCount = 0; // 当前选中的行数

  /// 数据源
  List<_Good> _goods = <_Good>[
    _Good('小米6x', 100, '手机', 1699.0),
    _Good('华为P20', 50, '手机', 4999.0),
    _Good('华硕a61', 50, '电脑', 5700.0),
    _Good('iphone7plus耳机', 9999, '耳机', 60.0),
    _Good('iphone7plus256g', 1, '手机', 4760.0),
    _Good('金士顿8g内存条', 66, '内存条', 399.0),
    _Good('西门子洗衣机9.0kg', 890, '家电', 10399.0),
    _Good('三星66寸液晶智能电视', 800, '家电', 20389.0),
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= _goods.length || index < 0) throw FlutterError("数据越界");
    final good = _goods[index];
    return DataRow.byIndex(
        index: index,
        cells: good.generateCell(),
        selected: good.selected,
        onSelectChanged: (isSelected) {
          if (isSelected == null) return;
          _selectOne(index, isSelected);
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _goods.length;

  @override
  int get selectedRowCount => _currentSelectedCount;

  void _selectOne(int index, bool isSelected) {
    _Good good = _goods[index];
    if (good.selected != isSelected) {
      _currentSelectedCount += isSelected ? 1 : -1;
      good.selected = isSelected;
      notifyListeners();
    }
  }

  void _selectAll(bool? checked) {
    if (checked == null) return;
    for (_Good good in _goods) {
      good.selected = checked;
    }
    _currentSelectedCount = checked ? _goods.length : 0;
    notifyListeners();
  }

  void _sort<T>(Comparable<T> getProperty(_Good good), bool b) {
    _goods.sort((_Good good1, _Good good2) {
      if (!b) {
        final temp = good1;
        good1 = good2;
        good2 = temp;
      }
      final Comparable<T> g1Value = getProperty(good1);
      final Comparable<T> g2Value = getProperty(good2);
      return Comparable.compare(g1Value, g2Value);
    });
    notifyListeners();
  }
}
