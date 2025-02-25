
//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512359 "Payroll Posting Setup Ver1"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll Posting Setup Ver1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Debit G/L Account"; Rec."Debit G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Debit G/L Account Name"; Rec."Debit G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Credit G/L Account"; Rec."Credit G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Credit G/L Account Name"; Rec."Credit G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deduction Type"; Rec."Sacco Deduction Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




