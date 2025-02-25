//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512467 "Transaction Type Card"
{
    PageType = Card;
    SourceTable = "Transaction Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }

                field("Has Schedule"; Rec."Has Schedule")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Span"; Rec."Transaction Span")
                {
                    ApplicationArea = Basic;
                }
                field("Default Mode"; Rec."Default Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Use Graduated Charge"; Rec."Use Graduated Charge")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1; "Transaction Charges")
            {
                SubPageLink = "Transaction Type" = field(Code),
                              "Account Type" = field("Account Type");
            }
        }
    }

    actions
    {
    }
}




