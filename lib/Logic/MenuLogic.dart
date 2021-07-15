class MenuLogic {
  int changeAmount(dynamic element, int op) {
    if (element.amount > 0 || op > 0) {
      int totalPrice = 0;
      totalPrice += ((element.price as int) * op);
      element.amount += op;
      return totalPrice;
      // widget.notifyParent(totalPrice);
    } else
      return 0;
  }
}
