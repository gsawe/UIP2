Pageextension 50102 "CustomerLedgerEntryExt" extends "Customer Ledger Entries"


{


    layout
    {
     addafter(Amount)
     {
    field(Descriptions;Rec.Description)
           {
            ApplicationArea = All;
           }

      field("Cheque No";Rec."External Document No.")
           {
            ApplicationArea = All;
           }
           field("Project Name"; Rec."Project Name")
           {
            ApplicationArea = All;
           }
          field("Plot Number"; Rec."Plot Number")
           {
            ApplicationArea = All;
           }

           field("Transaction Type"; Rec."Transaction Type")
           {
            ApplicationArea = All;
           }
          field("Plot Sale Document No"; Rec."Plot Sale Document No")
           {
            ApplicationArea = All;
           }

           
              }
    }


    }

 








