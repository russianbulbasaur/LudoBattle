enum HistoryEnum{
  games,transactions,referrals
}

extension HistoryFunctions on HistoryEnum{
  String getTitle(){
    switch(this){
      case HistoryEnum.games:
        return "Game History";
      case HistoryEnum.transactions:
        return "Transaction History";
      case HistoryEnum.referrals:
        return "Referrals History";
    }
  }

  String getDefaultText() {
    switch (this) {
      case HistoryEnum.games:
        return "You Haven't Played Any Games Yet";
      case HistoryEnum.transactions:
        return "You have no transactions yet";
      case HistoryEnum.referrals:
        return "No History Available";
    }
  }

  String getIconTitle() {
    switch (this) {
      case HistoryEnum.games:
        return "Recent 20 Games";
      case HistoryEnum.transactions:
        return "Recent 20 Transactions";
      case HistoryEnum.referrals:
        return "Recent 20 Referrals";
    }
  }

  String getTabTitle(){
    switch(this){
      case HistoryEnum.games:
        return "games";
      case HistoryEnum.transactions:
        return "transactions";
      case HistoryEnum.referrals:
        return "referrals";
    }
  }
}