
class EmiHistoryModel {
  final String productName;
  final String productIcon;
  final double totalAmount;
  final double paidAmount;
  final int totalMonths;
  final int paidMonths;
  final String status;
  final String nextDueDate;

  EmiHistoryModel({
    required this.productName,
    required this.productIcon,
    required this.totalAmount,
    required this.paidAmount,
    required this.totalMonths,
    required this.paidMonths,
    required this.status,
    required this.nextDueDate,
  });
}

class PaymentModel {
  final String title;
  final double amount;
  final String date;
  final String type;
  final String method;

  PaymentModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.method,
  });
}