page 51510008 "Project List"
{
    CardPageId = "Projects Card";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Projects;

    layout
    {
        area(Content)
        {
            repeater(ProjectList)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }

                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;

                }
                field(Cost; Rec.Cost)
                {
                    Caption = 'Cost Per Plot';
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
            action("Projects Listing")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction();
                begin
                    Report.Run(50000, true, true);
                end;
            }
        }
    }
}