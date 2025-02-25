page 51512554 "Due Diligence List Posted"
{
    Caption = 'Due Diligence List Posted';
    PageType = List;
    CardPageId = "Due Diligence Card Posted";
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Due Diligence";
    SourceTableView = where(Posted = filter(true), "Due Diligence Status" = filter(Project));
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
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
            }
        }
        area(Factboxes)
        {

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