page 51512558 "Title Processing List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Title Deeds";
    CardPageId = "Title Processing Card";
    SourceTableView = where(Issued = const(false));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;

                }

                field("Plot No"; Rec."Plot No")
                {
                    ApplicationArea = All;

                }
                field("Place Of Issue"; Rec."Place Of Issue")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}