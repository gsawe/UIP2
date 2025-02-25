page 51510232 "Lead Follow Ups"
{
    PageType = List;
    SourceTable = "Follow ups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry Date"; Rec."Entry Date")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Follow Up Purpose"; Rec."Follow Up Purpose")
                {
                }
                field("Next Follow up Date"; Rec."Next Follow up Date")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
            }
        }
    }

    actions
    {
    }
}

