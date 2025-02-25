page 51512602 "Title Processing List Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Title Deeds";
    CardPageId = "Title Processing Card Posted";
    SourceTableView = where(Issued = const(true));
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                field("Title Deed No"; Rec."Title Deed No")
                {
                    ApplicationArea = All;

                }
                field("Issued To Name"; Rec."Issued To Name")
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