//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50094 "Funds Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "Funds Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive"; Rec."Amount to Receive")
                {
                    ApplicationArea = Basic;
                }
                field("External Doc No."; Rec."External Doc No.")
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




