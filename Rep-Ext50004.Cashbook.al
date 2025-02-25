reportextension 50004 "Cash book" extends "Bank Acc. - Detail Trial Bal."
{

    dataset
    {
        // Add changes to dataitems and columns here
       add("Bank Account Ledger Entry")
       {
        column(Credit_Amount;"Credit Amount"){}
        column(Debit_Amount;"Debit Amount"){}
        
       }
    }
    
    requestpage
    {
        // Add changes to the requestpage here
    }
    
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }
}