page 51512601 "Received Title Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Received Titles";

    layout
    {
        area(Content)
        {
            group("Title Issueing Card")
            {
                field("Title Code"; Rec."Title Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ApplicationArea = All;
                }
                field("Title Deed Number"; Rec."Title Deed Number")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Serial Number"; Rec."Serial Number")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        myInt: Integer;
}