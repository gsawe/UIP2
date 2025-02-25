Pageextension 50103 "DtldCustomerLedgerEntryExt" extends "Detailed Cust. Ledg. Entries"


{


    layout
    {
        addafter(Amount)
        {
            field(Description;Rec.Description)
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
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = All;
            }

            
        }
    }

}










