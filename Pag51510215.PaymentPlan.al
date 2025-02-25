page 51510215 "Payment Plan"
{
    PageType = ListPart;
    SourceTable = "Payment Plan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Balance; Rec.Balance)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

