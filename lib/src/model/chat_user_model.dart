class ChatUser {
  ChatUser({
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.phoneNumber,
    required this.activeStatus,
    required this.created,
    required this.updated,
  });

  final String uid;
  static const String uidKey = "uid";

  final String username;
  static const String usernameKey = "username";

  final String profileImage;
  static const String profileImageKey = "profile_image";

  final String phoneNumber;
  static const String phoneNumberKey = "phone_number";

  final ActiveStatus? activeStatus;
  static const String activeStatusKey = "active_status";

  final DateTime? created;
  static const String createdKey = "created";

  final DateTime? updated;
  static const String updatedKey = "updated";

  ChatUser copyWith({
    String? uid,
    String? username,
    String? profileImage,
    String? phoneNumber,
    ActiveStatus? activeStatus,
    DateTime? created,
    DateTime? updated,
  }) {
    return ChatUser(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      activeStatus: activeStatus ?? this.activeStatus,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      uid: json["uid"] ?? "",
      username: json["username"] ?? "",
      profileImage: json["profile_image"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      activeStatus: json["active_status"] == null ? null : ActiveStatus.fromJson(json["active_status"]),
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
      updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "profile_image": profileImage,
        "phone_number": phoneNumber,
        "active_status": activeStatus?.toJson(),
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
      };
}

class ActiveStatus {
  ActiveStatus({
    required this.status,
    required this.active,
    required this.lastUpdate,
  });

  final String status;
  static const String statusKey = "status";

  final String active;
  static const String activeKey = "active";

  final DateTime? lastUpdate;
  static const String lastUpdateKey = "last_update";

  ActiveStatus copyWith({
    String? status,
    String? active,
    DateTime? lastUpdate,
  }) {
    return ActiveStatus(
      status: status ?? this.status,
      active: active ?? this.active,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  factory ActiveStatus.fromJson(Map<String, dynamic> json) {
    return ActiveStatus(
      status: json["status"] ?? "",
      active: json["active"] ?? "",
      lastUpdate: json["last_update"] == null ? null : DateTime.parse(json["last_update"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "active": active,
        "last_update": lastUpdate?.toIso8601String(),
      };
}
