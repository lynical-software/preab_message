import 'package:preab_message/preab_message.dart';

class RoomModel {
  RoomModel({
    required this.id,
    required this.lastMessage,
    required this.unread,
    required this.users,
    required this.userIds,
    required this.created,
    required this.updated,
  });

  final String id;
  static const String idKey = "id";

  final LastMessage? lastMessage;
  static const String lastMessageKey = "last_message";

  final MapData? unread;
  static const String unreadKey = "unread";

  final List<ChatUser> users;
  static const String usersKey = "users";

  final List<String> userIds;
  static const String userIdsKey = "user_ids";

  final DateTime? created;
  static const String createdKey = "created";

  final DateTime? updated;
  static const String updatedKey = "updated";

  RoomModel copyWith({
    String? id,
    LastMessage? lastMessage,
    MapData? unread,
    List<ChatUser>? users,
    List<String>? userIds,
    DateTime? created,
    DateTime? updated,
  }) {
    return RoomModel(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      unread: unread ?? this.unread,
      users: users ?? this.users,
      userIds: userIds ?? this.userIds,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory RoomModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final userJsonMapper = PreabSetting.instance.userJsonMapper;
    return RoomModel(
      id: json["id"] ?? "",
      lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
      unread: json["unread"],
      users: json["users"] == null ? [] : List<ChatUser>.from(json["users"]!.map((x) => userJsonMapper(x))),
      userIds: json["user_ids"] == null ? [] : List<String>.from(json["user_ids"]!.map((x) => x)),
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
      updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    final userToJsonMapper = PreabSetting.instance.userToJsonMapper;
    return {
      "id": id,
      "last_message": lastMessage?.toJson(),
      "unread": unread,
      "users": users.map((x) => userToJsonMapper(x)).toList(),
      "user_ids": userIds.map((x) => x).toList(),
      "created": created?.toIso8601String(),
      "updated": updated?.toIso8601String(),
    };
  }
}

class LastMessage {
  LastMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  final String sender;
  static const String senderKey = "sender";

  final String message;
  static const String messageKey = "message";

  final int timestamp;
  static const String timestampKey = "timestamp";

  LastMessage copyWith({
    String? sender,
    String? message,
    int? timestamp,
  }) {
    return LastMessage(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      sender: json["sender"] ?? "",
      message: json["message"] ?? "",
      timestamp: json["timestamp"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "message": message,
        "timestamp": timestamp,
      };
}
