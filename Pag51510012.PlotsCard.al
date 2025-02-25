page 51510012 "Plots Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Plots;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Plot Details")
            {
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Plot No"; Rec."Plot No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field(Availability; Rec.Availability)
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Title Deed No"; Rec."Title Deed No")
                {
                    ApplicationArea = All;

                }

                field(Price; Rec.Price)
                {
                    Editable = false;
                    ApplicationArea = All;

                }
            }
        }
    }

    /*     actions
        {
            area(Processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                    end;
                }
            }
        } */

    var
        myInt: Integer;
}