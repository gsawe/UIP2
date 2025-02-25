page 51510006 "Plots Application List"
{
    Caption = 'Plots Register List';
    PageType = List;
    UsageCategory = Lists;
    CardPageId = 51510007;
    ApplicationArea = All;
    SourceTable = "Plots Register";
    SourceTableView = where(Posted = const(false));
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
                }
                field("CLient No"; Rec."Client Code")
                {
                    ApplicationArea = All;
                }
                field("Plot Amount"; Rec."Plot Amount")
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