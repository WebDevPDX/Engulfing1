dateTime barStart;

void onBar() 
  {
    double candleA = Close[2]-Open[2];
    double candleB = Close[1]-Open[1];

    bool longPos = ( candleA < 0 ) && ( candleB > 0 ) && ( MathAbs(candleA) < MathAbs(candleB) );
    bool shortPos = ( candleA > 0 ) && ( candleB < 0 ) && ( MathAbs(candleA) < MathAbs(candleB) );

    //engulfing long
    if (longPos) 
      {
        //OrderSend(Symbol(), OP_BUY, 0.1, Ask, 2, stopLoss("long"), takeProfit("long"));
        Print("Entrysignal long: ", Ask, ", ", stopLoss("long"), ", ", takeProfit("long"));
      }
    
    //engulfing short
    if (shortPos) 
      {
        //OrderSend(Symbol(), OP_BUY, 0.1, Bid, 2, stopLoss("short"), takeProfit("short"));
        Print("Entrysignal long: ", Bid, ", ", stopLoss("short"), ", ", takeProfit("short"));
      }
  }

double stopLoss(string pos) 
  {
    double SL;
    if(pos == "long")
      SL = Low[1] - ((MarketInfo(Symbol(), MODE_SPREAD) - 10)/10000);
    if(pos == "short")
      SL = High[1] + ((MarketInfo(Symbol(), MODE_SPREAD) + 10)/10000);
    return(SL);
  }
   
double takeProfit(string pos)
   {
      double TP;
      if(pos == "long")
        TP = Bid + ((MarketInfo(Symbol(), MODE_SPREAD) + 10)/10000)*3;
      if(pos == "short")
        TP = Ask + ((MarketInfo(Symbol(), MODE_SPREAD) + 10)/10000)*3;
      return(TP);
   }


void OnTick()
  {
    if (barStart != Time[0]) 
      {
        onBar();
        barStart = Time[0];
      }
   
  }

//TODO:
// - figure out closing the position on opposing signal
// - get account info
// - calculate position size
// - run tests