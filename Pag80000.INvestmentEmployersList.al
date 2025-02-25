page 80000 "INvestment Employers List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Investment Employers";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;

                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = all;
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