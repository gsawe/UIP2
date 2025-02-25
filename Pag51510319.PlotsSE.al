page 51510319 "Plots SE"
{
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Plots;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plot No"; Rec."Plot No")
                {
                    Editable = false;
                }
                field(Size; Rec.Size)
                {
                    Editable = false;
                }
                field("Title No"; Rec."Title No")
                {
                    Editable = false;
                }
                field(Price; Rec.Price)
                {

                    trigger OnValidate()
                    begin
                        if UserSet.Get(UserId) then begin
                            if UserSet."Allow Plot Details Change" = false then
                                Error('You are not allowed to modify plot price.');
                        end;
                    end;
                }
                field(Availability; Rec.Availability)
                {
                    Editable = false;
                }
                field("Held By"; Rec."Held By")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        PlotsEditable: Boolean;
        UserSet: Record "User Setup";
}

