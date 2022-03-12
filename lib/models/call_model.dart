class CallModel {
  String? callerId;
  String? callerName;
  String? callerImg;
  String? receiverId;
  String? receiverName;
  String? receiverImg;
  String? channelId;
  bool? hasDialled;

  CallModel({
    this.callerId,
    this.callerImg,
    this.callerName,
    this.channelId,
    this.hasDialled,
    this.receiverId,
    this.receiverImg,
    this.receiverName,
  });

  CallModel.fromJson(Map<String, dynamic> json) {
    callerId = json['callerId'];
    callerName = json['callerName'];
    callerImg = json['callerImg'];
    channelId = json['channelId'];
    hasDialled = json['hasDialled'];
    receiverId = json['receiverId'];
    receiverImg = json['receiverImg'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'callerId' : callerId,
    'callerName' : callerName,
    'callerImg' : callerImg,
    'channelId' : channelId,
    'hasDialled' : hasDialled,
    'receiverId' : receiverId,
    'receiverImg' : receiverImg,
    'receiverName' : receiverName
    };
  }
}
