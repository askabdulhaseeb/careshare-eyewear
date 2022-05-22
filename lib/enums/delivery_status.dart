enum DeliveryStatusEnum {
  pending,
  onTheWay,
  delivered,
}

class DeliveryStatusConvertor {
  static String getString(DeliveryStatusEnum status) {
    if (status == DeliveryStatusEnum.pending) {
      return 'Pending';
    } else if (status == DeliveryStatusEnum.onTheWay) {
      return 'On The Way';
    } else {
      return 'Delivered';
    }
  }

  static DeliveryStatusEnum getEnum(String status) {
    if (status == 'pending') {
      return DeliveryStatusEnum.pending;
    } else if (status == 'onTheWay') {
      return DeliveryStatusEnum.onTheWay;
    } else {
      return DeliveryStatusEnum.delivered;
    }
  }

  static String getJson(DeliveryStatusEnum status) {
    if (status == DeliveryStatusEnum.pending) {
      return 'pending';
    } else if (status == DeliveryStatusEnum.onTheWay) {
      return 'onTheWay';
    } else {
      return 'delivered';
    }
  }

}
