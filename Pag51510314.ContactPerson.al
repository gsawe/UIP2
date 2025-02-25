page 51510314 "Contact Person"
{
    PageType = ListPart;
    SourceTable = "Contact Person";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field("Phone No"; Rec."Phone No")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
            }
        }
    }

    actions
    {
    }
}

