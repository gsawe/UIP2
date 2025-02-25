pageextension 50100 "CustomerCardExt" extends "Customer Card"
{
    layout
    {
     addafter(Name)
     {
           field(ISNormalMember; Rec.ISNormalMember)
           {
            ApplicationArea = All;
           }
     }
    }
}