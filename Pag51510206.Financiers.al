page 51510206 "Financiers"
{
    PageType = List;
    SourceTable = Financiers;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec.code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

