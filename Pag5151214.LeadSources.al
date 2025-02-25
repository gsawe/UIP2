page 5151214 "Lead Sources"
{
    PageType = List;
    SourceTable = "Lead Sources";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
            }
        }
    }

    actions
    {
    }
}

