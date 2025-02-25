page 51510315 "Witness"
{
    PageType = ListPart;
    SourceTable = Witness;

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
                field(ID; Rec.ID)
                {
                }
            }
        }
    }

    actions
    {
    }
}

