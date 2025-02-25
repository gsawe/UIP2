page 51510231 "Available plots"
{
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Plots;
    SourceTableView = WHERE(Availability = FILTER(Available));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                }
            }
        }
    }

    actions
    {
    }
}

