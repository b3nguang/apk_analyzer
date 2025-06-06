// 描述项数据模型
import 'package:flutter/material.dart';

// 表格数据模型
class MyTableData {
  final String title;
  final List<String> headers;
  final List<MyTableRow> rows;

  MyTableData({required this.title, required this.headers, required this.rows});
}

// 表格行数据模型
class MyTableRow {
  final List<String> cells;
  final Color? color;

  MyTableRow({required this.cells, this.color});
}