import 'dart:io';

import 'package:preab_message/preab_message.dart';

extension ATT on ChatAttachment {
  bool get localFileExist {
    return File(fileName).existsSync();
  }

  String get pathUri {
    return localFileExist ? fileName : url;
  }
}

extension MessageX on MessageModel {
  bool get isMine {
    return PreabSetting.instance.currentUser.uid == sender?.uid;
  }
}

extension RoomModelX on RoomModel {
  get me => PreabSetting.instance.currentUser;

  String get roomName {
    try {
      return users.where((element) => element.uid != me.uid).first.username;
    } catch (e) {
      return "Saved Messages";
    }
  }

  ChatUser get otherUser {
    try {
      return users.firstWhere((element) => element.uid != me.uid);
    } catch (e) {
      return me;
    }
  }

  int get myUnreadCount {
    if (unread == null) return 0;
    return unread![me.uid] != null ? unread![me.uid] as int : 0;
  }

  bool get isLastMessageMine {
    return lastMessage?.sender == me.uid;
  }
}

typedef MapData = Map<String, dynamic>;
