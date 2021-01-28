class LeaderBoard {
  List<LeaderBoardList> _leaderBoardList;
  Status _status;

  LeaderBoard({List<LeaderBoardList> leaderBoardList, Status status}) {
    this._leaderBoardList = leaderBoardList;
    this._status = status;
  }

  List<LeaderBoardList> get leaderBoardList => _leaderBoardList;
  set leaderBoardList(List<LeaderBoardList> leaderBoardList) =>
      _leaderBoardList = leaderBoardList;
  Status get status => _status;
  set status(Status status) => _status = status;

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    if (json['leaderBoardList'] != null) {
      _leaderBoardList = new List<LeaderBoardList>();
      json['leaderBoardList'].forEach((v) {
        _leaderBoardList.add(new LeaderBoardList.fromJson(v));
      });
    }
    _status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._leaderBoardList != null) {
      data['leaderBoardList'] =
          this._leaderBoardList.map((v) => v.toJson()).toList();
    }
    if (this._status != null) {
      data['status'] = this._status.toJson();
    }
    return data;
  }
}

class LeaderBoardList {
  String _email;
  int _examId;
  int _markObtained;
  int _totalMark;

  LeaderBoardList({String email, int examId, int markObtained, int totalMark}) {
    this._email = email;
    this._examId = examId;
    this._markObtained = markObtained;
    this._totalMark = totalMark;
  }

  String get email => _email;
  set email(String email) => _email = email;
  int get examId => _examId;
  set examId(int examId) => _examId = examId;
  int get markObtained => _markObtained;
  set markObtained(int markObtained) => _markObtained = markObtained;
  int get totalMark => _totalMark;
  set totalMark(int totalMark) => _totalMark = totalMark;

  LeaderBoardList.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _examId = json['examId'];
    _markObtained = json['markObtained'];
    _totalMark = json['totalMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['examId'] = this._examId;
    data['markObtained'] = this._markObtained;
    data['totalMark'] = this._totalMark;
    return data;
  }
}

class Status {
  String _message;
  int _statusCode;

  Status({String message, int statusCode}) {
    this._message = message;
    this._statusCode = statusCode;
  }

  String get message => _message;
  set message(String message) => _message = message;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;

  Status.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['statusCode'] = this._statusCode;
    return data;
  }
}
