page 51512553 "Due Diligence List Part"
{
    Caption = 'Due Diligence List Part';
    PageType = ListPart;
    CardPageId = "Due Diligence Card Posted";
    UsageCategory = Lists;
    SourceTableView = where(Posted = filter(true));
    ApplicationArea = All;
    SourceTable = "Due Diligence";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Parcel Owner"; Rec."Parcel Owner")
                {
                    ApplicationArea = All;
                }
                field("Parcel Location"; Rec."Parcel Location")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}