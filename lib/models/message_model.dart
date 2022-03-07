class MessageModel {
  String? message;
  String? receiverId;
  String? senderId;
  String? dateTime;

  MessageModel({this.message, this.dateTime, this.receiverId, this.senderId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'receiverId' : receiverId,
      'senderId' : senderId,
      'dateTime' : dateTime,
    };
  }
}
