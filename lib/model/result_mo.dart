class Result {
  Result({
    this.code,
    this.method,
    this.requestParams,
  });

  int code;
  String method;
  String requestParams;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        method: json["method"],
        requestParams: json["requestParams"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "method": method,
        "requestParams": requestParams,
      };
}
