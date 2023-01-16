class NotificationsModel {
  int id = 0;
  String? title;
  String? subTitle;
  DateTime dateTime;
  String? icon;
  String? payLoad;

  NotificationsModel(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.dateTime,
      this.payLoad});

  NotificationsModel.scheduled(this.id, this.title, this.subTitle,
      this.dateTime, this.icon, this.payLoad);
}
