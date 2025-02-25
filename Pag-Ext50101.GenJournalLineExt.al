Pageextension 50101 "GenJournalLineExt" extends "General Journal"


{


    layout
    {
     addafter(Amount)
     {
           field("Plot Sale Document No"; Rec."Plot Sale Document No")
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
     }
          addbefore(Amount)
     {
           field("Transaction Type"; Rec."Transaction Type")
           {
            ApplicationArea = All;
           }
     }
    }

    }

 








