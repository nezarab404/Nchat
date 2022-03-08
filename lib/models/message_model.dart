class MessageModel {
  String? message;
  String? receiverId;
  String? senderId;
  String? dateTime;
  bool? isImage;

  MessageModel({this.message, this.dateTime, this.receiverId, this.senderId , this.isImage = false});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    isImage = json['isImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'isImage': isImage,
    };
  }
}
