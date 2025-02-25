page 51510011 "Plots Part"
{
    Editable = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = Plots;
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
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
                }
                field("Plot No"; Rec."Plot No")
                {
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
                field(Availability; Rec.Availability)
                {
                    StyleExpr = Style;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }
            }
        }
    }

    actions
    {

    }
    trigger OnInit()
    var
        myInt: Integer;
    begin
        Style := '';
        if Rec.Availability = Rec.Availability::Available then
            Style := 'Favorable';
        if Rec.Availability = Rec.Availability::Sold then
            Style := 'Unfavorable';
    end;

    var
        Style: Text[100];
}

