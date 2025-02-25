page 51510211 "Lead Tasks"
{
    PageType = List;
    SourceTable = "Lead Tasks";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Task Type"; Rec."Task Type")
                {
                }
                field("Date Scheduled"; Rec."Date Scheduled")
                {
                }
                field("Time Scheduled"; Rec."Time Scheduled")
                {
                }
                field(Description; Rec.Description)
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

