page 51510004 "Plots"
{
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Plots;
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "Plots Card";
    DeleteAllowed = false;
    SourceTableView = order(ascending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Project; Rec.Project)
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = false;
                }
                field("Plot No"; Rec."Plot No")
                {
                    Caption = 'Serial';
                }
                field(Size; Rec.Size)
                {
                }
                field("Title No"; Rec."Title No")
                {
                }
                field(Price; Rec.Price)
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    StyleExpr = Style;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    StyleExpr = Style;
                }
                field(Availability; Rec.Availability)
                {
                    StyleExpr = Style;
                    //Visible=false;
                }



            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Plots Listing")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction();
                begin
                    Report.Run(50002, true, true);
                end;
            }

            action("Process report")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                //Visible=false;
                trigger OnAction();
                begin
                    Report.Run(50004, true, true);
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        Style := '';
        if Rec.Availability = Rec.Availability::Available then
            Style := 'Unfavorable';
        if Rec.Availability = Rec.Availability::Sold then
            Style := 'Favorable';
    end;


    var
        Style: Text[80];
}

