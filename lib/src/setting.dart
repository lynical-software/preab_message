import 'package:flutter/material.dart';
import 'package:preab_message/preab_message.dart';
import 'package:preab_message/src/type/types.dart';

class PreabSetting {
  PreabSetting._privateConstructor();

  static final PreabSetting instance = PreabSetting._privateConstructor();

  String? _messageCollection;

  String get messageCollection {
    assert(_messageCollection != null);
    if (_messageCollection == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _messageCollection!;
  }

  String? _roomCollection;

  String get roomCollection {
    assert(_roomCollection != null);
    if (_roomCollection == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _roomCollection!;
  }

  ChatUser? _currentUser;

  ChatUser get currentUser {
    assert(_currentUser != null);
    if (_currentUser == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _currentUser!;
  }

  set currentUser(ChatUser currentUser) {
    _currentUser = currentUser;
  }

  UserJsonMapper? _userJsonMapper;

  UserJsonMapper get userJsonMapper {
    assert(_userJsonMapper != null);
    if (_userJsonMapper == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _userJsonMapper!;
  }

  set userJsonMapper(UserJsonMapper userJsonMapper) {
    _userJsonMapper = userJsonMapper;
  }

  void init({
    required ChatUser currentUser,
    required UserJsonMapper userJsonMapper,
    String roomCollection = "rooms",
    String messageCollection = "messages",
  }) {
    _messageCollection = messageCollection;
    _userJsonMapper = userJsonMapper;
    _roomCollection = roomCollection;
    _currentUser = currentUser;
  }
}
