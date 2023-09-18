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

  String? _storagePath;

  String get storagePath {
    assert(_storagePath != null);
    if (_storagePath == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _storagePath!;
  }

  ////Current user
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
  ////Current user

  ////Json from mapper
  UserFromJsonMapper? _userJsonMapper;

  UserFromJsonMapper get userJsonMapper {
    assert(_userJsonMapper != null);
    if (_userJsonMapper == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _userJsonMapper!;
  }

  set userJsonMapper(UserFromJsonMapper userJsonMapper) {
    _userJsonMapper = userJsonMapper;
  }

  ////Json from mapper

  ////Json to mapper
  UserToJsonMapper? _userToJsonMapper;

  UserToJsonMapper get userToJsonMapper {
    assert(_userToJsonMapper != null);
    if (_userToJsonMapper == null) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
    return _userToJsonMapper!;
  }

  set userToJsonMapper(UserToJsonMapper userToJsonMapper) {
    _userToJsonMapper = userToJsonMapper;
  }
  ////Json to mapper

  void init({
    required ChatUser currentUser,
    required UserFromJsonMapper userJsonMapper,
    required UserToJsonMapper userToJsonMapper,
    String roomCollection = "rooms",
    String messageCollection = "messages",
    String storagePath = "/storage",
  }) {
    _messageCollection = messageCollection;
    _userJsonMapper = userJsonMapper;
    _userToJsonMapper = userToJsonMapper;
    _roomCollection = roomCollection;
    _currentUser = currentUser;
    _storagePath = storagePath;
  }
}
