pageextension 51512182 "Ledger Entries Ext" extends "Bank Account Ledger Entries"
{

    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;

            }

        }

    }

}