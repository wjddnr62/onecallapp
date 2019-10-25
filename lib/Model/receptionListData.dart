class ReceptionListData {
  int receptionTime; // 대행접수시간
  int assignmentTime; // 배정시간
  String businessName; // 업소명
  dynamic numberAddress; // 지번주소 (개별일시 String, 묶음일시 List)
  dynamic loadAddress; // 도로명주소 (개별일시 String, 묶음일시 List)
  String mainTel; // 상점 대표전화
  String mainPhone; // 상점 휴대전화
  String mainNumberAddress; // 상점 지번 주소
  String mainLoadAddress; // 상점 도로명 주소
  dynamic customerPhone; // 고객 폰 번호 (개별일시 String, 묶음일시 List)
  int paymentAmountAll; // 총 결제 금액
  dynamic paymentAmount; // 결제 금액 (개별일시 Int, 묶음일시 List)
  dynamic deliveryAmount; // 배달 대행 금액 (개별일시 Int, 묶음일시 List)
  dynamic paymentType; // 0 = 카드,  1 = 완불, 2 = 현금, 3 = 이체 (개별일시 Int, 묶음일시 List)
  int deliveryType; // 0 = 개별, 1 = 묶음
  dynamic check; // 0 = 결제 필요, 1 = 결제 완료

  ReceptionListData(
      {this.receptionTime,
      this.assignmentTime,
      this.businessName,
      this.numberAddress,
      this.loadAddress,
      this.mainTel,
      this.mainPhone,
      this.mainNumberAddress,
      this.mainLoadAddress,
      this.customerPhone,
      this.paymentAmountAll,
      this.paymentAmount,
      this.deliveryAmount,
      this.paymentType,
      this.deliveryType,
      this.check});
}
