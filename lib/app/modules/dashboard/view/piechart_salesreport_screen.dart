import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';

class SalesReportScreen extends StatelessWidget {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        backgroundColor: const Color(0xFF1ABC9C),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          double totalSales = controller.totalAmount.value;
          double totalCredit = controller.totalCredit.value;
          double totalValue = totalSales + totalCredit;
          int totalInstock = controller.totalInstock.value;
          int totalOutstock = controller.totalOutstock.value;

          return Column(
            children: [
              _buildSummaryCards(totalSales, totalCredit, totalInstock, totalOutstock),
              _buildPieChartSection(totalSales, totalCredit, totalValue),
              _buildDetailedStats(totalSales, totalCredit, totalValue),
              _buildInventorySection(totalInstock, totalOutstock),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSummaryCards(double totalSales, double totalCredit, int totalInstock, int totalOutstock) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  'Total Sales',
                  '₹${totalSales.toStringAsFixed(2)}',
                  Icons.attach_money,
                  const Color(0xFF1ABC9C),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCard(
                  'Total Credit',
                  '₹${totalCredit.toStringAsFixed(2)}',
                  Icons.credit_card,
                  const Color(0xFFE74C3C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  'In Stock',
                  totalInstock.toString(),
                  Icons.inventory,
                  const Color(0xFF3498DB),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCard(
                  'Out Stock',
                  totalOutstock.toString(),
                  Icons.local_shipping,
                  const Color(0xFFE67E22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartSection(double totalSales, double totalCredit, double totalValue) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: totalSales,
              title: '${((totalSales/totalValue)*100).toStringAsFixed(1)}%',
              color: const Color(0xFF1ABC9C),
              radius: 100,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              value: totalCredit,
              title: '${((totalCredit/totalValue)*100).toStringAsFixed(1)}%',
              color: const Color(0xFFE74C3C),
              radius: 100,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildDetailedStats(double totalSales, double totalCredit, double totalValue) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLegend('Paid Amount', totalSales, const Color(0xFF1ABC9C)),
          const SizedBox(height: 10),
          _buildLegend('Credit Amount', totalCredit, const Color(0xFFE74C3C)),
          const SizedBox(height: 20),
          _buildTotalCard(totalValue),
        ],
      ),
    );
  }

  Widget _buildLegend(String title, double value, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$title: ₹${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTotalCard(double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Value:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '₹${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySection(int totalInstock, int totalOutstock) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inventory Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInventoryCard('Total In Stock', totalInstock, Icons.inventory),
          const SizedBox(height: 8),
          _buildInventoryCard('Total Out Stock', totalOutstock, Icons.local_shipping),
        ],
      ),
    );
  }

  Widget _buildInventoryCard(String title, int value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}