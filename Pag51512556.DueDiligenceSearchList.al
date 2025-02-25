page 51512556 "Due Diligence Search List"
{
    Caption = 'Due Diligence Search List';
    PageType = List;
    CardPageId = "Due Diligence Search Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Due Diligence";
    SourceTableView = where("Due Diligence Status" = filter(Search));
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
                field("Parcel Type"; Rec."Parcel Type")
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