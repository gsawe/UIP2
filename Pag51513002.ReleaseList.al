page 51513002 "Release List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Plots Release";
    CardPageId = "Release Card";


    layout
    {
        area(Content)
        {
            repeater(ReleaseList)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;

                }


                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;

                }

                field("Project Code"; Rec."Project Code")
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
            action("Post Release")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}