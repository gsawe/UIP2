page 51512555 "Due Diligence Card Posted"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Due Diligence";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Parcel Owner"; Rec."Parcel Owner")
                {
                    ApplicationArea = All;
                }
                field("Parcel Size In Acres"; Rec."Parcel Size In Acres")
                {
                    ApplicationArea = All;
                }
                field("Parcel Size In words"; Rec."Parcel Size In words")
                {
                    ApplicationArea = All;
                }
                field("Parcel Location"; Rec."Parcel Location")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Acre"; Rec."Cost Per Acre")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Plot"; Rec."Cost Per Plot")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
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
            action("Post DueDiligence")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    If Confirm('Are you sure you want to post this record?', true, false) = true then begin
                        Rec.Posted := true;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}