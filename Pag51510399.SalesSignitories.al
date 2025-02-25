page 51510399 "Sales Signitories"
{
    PageType = List;
    SourceTable = Signitories;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No"; Rec."Customer No")
                {
                }
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

