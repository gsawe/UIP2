page 51512600 "Received Title Deed List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Received Titles";
    CardPageId = "Received Title Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Title Code"; Rec."Title Code")
                {
                    ApplicationArea = All;

                }
                field("Title Deed Number"; Rec."Title Deed Number")
                {
                    ApplicationArea = All;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Code';

                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ApplicationArea = All;

                }
                field("Member Name"; Rec."Member Name")
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