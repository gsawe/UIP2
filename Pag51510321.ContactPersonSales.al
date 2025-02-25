page 51510321 "Contact Person Sales"
{
    PageType = List;
    SourceTable = "Contact Person Sales";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field(Contact; Rec.Contact)
                {
                }
            }
        }
    }

    actions
    {
    }
}

