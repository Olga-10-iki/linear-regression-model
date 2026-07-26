import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Render API URL (works on Android and Web)
  static const String baseUrl =
      "https://receiver-balance-api.onrender.com";

  static Future<Map<String, dynamic>> predictBalance({
    required double amount,
    required double senderBalanceBefore,
    required double senderBalanceAfter,
    required double receiverBalanceBefore,
    required int transactionType,
    required int hour,
    required int month,
    required int dayOfWeek,
    required int deviceType,
    required int region,
    required int isFraud,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "amount": amount,
        "sender_balance_before": senderBalanceBefore,
        "sender_balance_after": senderBalanceAfter,
        "receiver_balance_before": receiverBalanceBefore,
        "transaction_type": transactionType,
        "hour": hour,
        "month_2026": month,
        "day_of_week": dayOfWeek,
        "device_type": deviceType,
        "region": region,
        "is_fraud": isFraud,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Server Error (${response.statusCode}): ${response.body}",
      );
    }
  }
}