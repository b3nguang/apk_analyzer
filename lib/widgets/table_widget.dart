import 'package:apk_analyzer/utils/table.dart';
import 'package:apk_analyzer/widgets/dialog_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDataTable extends StatelessWidget {
  final List<String> headers;
  final List<MyTableRow> rows;

  const MyDataTable({
    super.key,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
          child: DataTable2(
            columnSpacing: 16,
            horizontalMargin: 12,
            headingRowHeight: 40,
            minWidth: 10,
            isHorizontalScrollBarVisible: true,
            isVerticalScrollBarVisible: true,
            headingRowColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) => Colors.blue[50]!,
            ),
            columns: headers
                .map(
                  (header) => DataColumn2(
                    label: Text(
                      header,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      
                    ),
                    fixedWidth: header == '序号' ? 40.0 : null, //序号列不能太宽
                  ),
                )
                .toList(),
            rows: rows
                .map(
                  (row) => DataRow(
                    cells: row.cells
                        .map(
                          (cell) => DataCell(
                            Text(cell,style: TextStyle(color: row.color),),
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: cell));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$cell已复制到剪贴板'),duration: Duration(seconds: 1)),
                              );
                            },
                            onDoubleTap: () {
                              MyDialog(context, '详情', cell);
                            },
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
    //     ),
    //   ),
    );
  }
}