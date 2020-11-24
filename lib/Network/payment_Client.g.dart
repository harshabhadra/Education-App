// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_Client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PaymentClient implements PaymentClient {
  _PaymentClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.razorpay.com/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<String> paySubs(paymentRequest) async {
    ArgumentError.checkNotNull(paymentRequest, 'paymentRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(paymentRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<String>('/orders',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
