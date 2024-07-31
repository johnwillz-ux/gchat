class ChatModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String timestamp;

  ChatModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senderId: json["senderId"],
      senderEmail: json["senderEmail"],
      receiverId: json["receiverId"],
      message: json["message"],
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "message": message,
      "timestamp": timestamp,
    };
  }
}