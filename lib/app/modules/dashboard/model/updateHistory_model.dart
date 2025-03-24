class UpdateHistoryModel {
  final String id;
  final String transactionId;
  final String storeName;
  final String employeeName;
  final DateTime updatedAt;
  final Map<String, dynamic> originalData;
  final Map<String, dynamic> updatedData;
  final List<String> changedFields;
  final String reason;
  
  UpdateHistoryModel({
    required this.id,
    required this.transactionId,
    required this.storeName,
    required this.employeeName,
    required this.updatedAt,
    required this.originalData,
    required this.updatedData,
    required this.changedFields,
    required this.reason,
  });
}