//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512465 "Front Office Charges"
{
    PageType = Card;
    SourceTable = Charges;
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Amount"; Rec."Sacco Amount")
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




