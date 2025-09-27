import 'package:flutter/material.dart';
import '../models/data_item.dart';

class DataTableWidget extends StatelessWidget {
  final List<DataItem> dataItems;
  final Function(DataItem)? onItemSelected;

  const DataTableWidget({
    super.key,
    required this.dataItems,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Active', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: dataItems.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item.id.toString())),
                DataCell(Text(item.name)),
                DataCell(Text(item.category)),
                DataCell(Text(item.status)),
                DataCell(Text(item.value.toString())),
                DataCell(Text(item.date)),
                DataCell(Text(item.active)),
              ],
              onSelectChanged: (selected) {
                if (selected == true) {
                  onItemSelected?.call(item);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
