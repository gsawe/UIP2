page 51510009 "Plots Application List Posted"
{
    Caption = 'Plots Register List';
    PageType = List;
    UsageCategory = Lists;
    CardPageId = 51510010;
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    SourceTable = "Plots Register";
    SourceTableView = where(Posted = const(true));

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
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project Code';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;

                }

                field("Plot No"; Rec."Plot No")
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
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;

                }

                field("Correct Plot No"; Rec."Correct Plot No")
                {
                    ApplicationArea = All;
                    Visible = false;
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
            action("Plots Register")
            {
                ApplicationArea = All;
                PromotedCategory = Report;
                Promoted = TRUE;
                Image = Report;
                trigger OnAction();
                begin
                    Report.Run(50001, true, false);
                end;
            }
        }
    }
}