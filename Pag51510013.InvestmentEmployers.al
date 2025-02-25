page 51510013 "Investment Employers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Investment Employers";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;

                }
                field("Employer Name"; Rec."Employer Name")
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