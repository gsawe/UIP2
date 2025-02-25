//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50063 "Checkoff Processing Lines-D"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    //ApplicationArea = all;
    SourceTable = "Checkoff Lines-Distributed-NT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff No"; Rec."Checkoff No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field(Deposits; Rec.Deposits)
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}




