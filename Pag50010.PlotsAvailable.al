page 50010 "Plots Available"
{
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Plots;
    SourceTableView = WHERE(Availability=CONST(Available));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plot No";Rec."Plot No")
                {
                    Editable = false;
                }
                field(Size;Rec.Size)
                {
                    Editable = false;
                }
                field("Title No";Rec."Title No")
                {
                    Editable = false;
                }
                field(Price;Rec.Price)
                {

                    trigger OnValidate()
                    begin
                        if UserSet.Get(UserId) then begin
                        if UserSet."Allow Plot Details Change"=false then
                        Error('You are not allowed to modify plot price.');
                        end;
                    end;
                }
                field("Amount Payable";Rec."Amount Payable")
                {
                }
                field("ID Number";Rec."ID Number")
                {
                }
                field("Customer Id";Rec."Customer Id")
                {
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Sale Date";Rec."Sale Date")
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

