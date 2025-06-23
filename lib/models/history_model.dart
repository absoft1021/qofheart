class HistoryModel {
  String orderId;
  String amount;
  String desc;
  String status;
  String prevBal;
  String newBal;
  String date;

  HistoryModel(
      {required this.orderId,
      required this.amount,
      required this.desc,
      required this.status,
      required this.prevBal,
      required this.newBal,
      required this.date});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        orderId: json['OrderId'],
        amount: json['Amount'],
        desc: json['Description'],
        status: json['Status'],
        prevBal: json['PreviousBalance'],
        newBal: json['NewBalance'],
        date: json['Date'],
      );
}
