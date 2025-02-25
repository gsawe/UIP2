page 51512551 "Due Diligence List"
{
    Caption = 'Due Diligence List';
    PageType = List;
    CardPageId = "Due Diligence Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Due Diligence";
    SourceTableView = where("Due Diligence Status" = const(Registration), Posted = filter(false));
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
                    // Rec."Due Diligence Status"::
                end;
            }
        }
    }
}