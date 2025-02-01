import 'package:flutter/material.dart';

class PriceChangeBoard extends StatelessWidget {
  const PriceChangeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          verticalInside: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          horizontalInside: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        columnWidths: const {
          0: FlexColumnWidth(0.7),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1.3),
          4: FlexColumnWidth(1),
        },
        children: [
          // Header Row
          TableRow(
            children: [
              Container(height: 20),
              _buildHeaderCell('REG'),
              _buildHeaderCell('PLUS'),
              _buildHeaderCell('PREMIUM'),
              _buildHeaderCell('DIESEL'),
            ],
          ),
          // Cash Prices Row
          TableRow(
            children: [
              _buildPaymentTypeCell('CASH'),
              _buildPriceCell('2.34'),
              _buildPriceCell('2.89'),
              _buildPriceCell('2.99'),
              _buildPriceCell('3.14'),
            ],
          ),
          // Credit Prices Row
          TableRow(
            children: [
              _buildPaymentTypeCell('CREDIT'),
              _buildPriceCell('2.44'),
              _buildPriceCell('2.89'),
              _buildPriceCell('2.99'),
              _buildPriceCell('3.14'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPaymentTypeCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildPriceCell(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
