
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VehicleExpense {
  final String id;
  final String vehicleId;
  final String vehiclePlateNo;
  final String employeeId;
  final String employeeName;
  final String expenseType;
  final double amount;
  final DateTime date;
  final double odometerReading;
  final String? notes;
  final DateTime createdAt;

  VehicleExpense({
    required this.id,
    required this.vehicleId,
    required this.vehiclePlateNo,
    required this.employeeId,
    required this.employeeName,
    required this.expenseType,
    required this.amount,
    required this.date,
    required this.odometerReading,
    this.notes,
    required this.createdAt,
  });

  String get formattedDate => DateFormat('MMM dd, yyyy').format(date);

  factory VehicleExpense.fromJson(Map<String, dynamic> json) {
    return VehicleExpense(
      id: json['id'],
      vehicleId: json['vehicleId'],
      vehiclePlateNo: json['vehiclePlateNo'] ?? '',
      employeeId: json['employeeId'],
      employeeName: json['employeeName'] ?? '',
      expenseType: json['expenseType'],
      amount: (json['amount'] is int) 
          ? (json['amount'] as int).toDouble() 
          : json['amount'],
      date: (json['date'] is Timestamp) 
          ? (json['date'] as Timestamp).toDate() 
          : DateTime.parse(json['date'].toString()),
      odometerReading: (json['odometerReading'] is int) 
          ? (json['odometerReading'] as int).toDouble() 
          : json['odometerReading'],
      notes: json['notes'],
      createdAt: (json['createdAt'] is Timestamp) 
          ? (json['createdAt'] as Timestamp).toDate() 
          : DateTime.parse(json['createdAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleId': vehicleId,
      'vehiclePlateNo': vehiclePlateNo,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'expenseType': expenseType,
      'amount': amount,
      'date': date,
      'odometerReading': odometerReading,
      'notes': notes,
      'createdAt': createdAt,
    };
  }
}