class MenuLogic {
  int changeAmount(dynamic element, int op) {
    int meatPrice = 0;
    try{
      element.meatChoice.forEach((e){
        meatPrice += (e.price as int) * (e.amount as int);
      });
    }catch(e){
      print('No MeatChoice...');
    }
    if (element.amount > 0 || op > 0) {
      int totalChanged = 0;
      totalChanged += ((element.price as int) * op);
      totalChanged += meatPrice * op;
      element.amount += op;
      return totalChanged;
      // widget.notifyParent(totalChanged);
    } else
      return 0;
  }
}
