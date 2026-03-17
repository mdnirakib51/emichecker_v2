
class DashboardUtils {
  /// Format number with comma separator — e.g. 34200 → "34,200"
  static String formatAmount(double amount) {
    if (amount >= 1000) {
      final formatted = amount.toStringAsFixed(0);
      final result = StringBuffer();
      int count = 0;
      for (int i = formatted.length - 1; i >= 0; i--) {
        if (count > 0 && count % 3 == 0) result.write(',');
        result.write(formatted[i]);
        count++;
      }
      return result.toString().split('').reversed.join('');
    }
    return amount.toStringAsFixed(0);
  }

  /// EMI formula: P × r × (1+r)^n / ((1+r)^n − 1)
  static double calculateEmi(double principal, double annualRate, int months) {
    if (annualRate == 0) return principal / months;
    final r = annualRate / 12 / 100;
    final emi = principal * r * _pow(1 + r, months) / (_pow(1 + r, months) - 1);
    return emi;
  }

  static double _pow(double base, int exp) {
    double result = 1;
    for (int i = 0; i < exp; i++) {
      result *= base;
    }
    return result;
  }
}