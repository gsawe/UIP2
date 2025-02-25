//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512423 "Employer Card"
{
    PageType = Card;
    SourceTable = "Employers Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Physical Location"; Rec."Employer Physical Location")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Email"; Rec."Employer Email")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Phone No"; Rec."Employer Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person Mobile No"; Rec."Contact Person Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Type"; Rec."Payment Type")
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




