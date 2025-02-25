page 51510235 "Plot Sales List Approved"
{
    CardPageID = "Plot Sales Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sale/Offer";
    SourceTableView = WHERE("Sale Type" = CONST(Sale),
                            "Is Active" = CONST(YES));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sale Type"; Rec."Sale Type")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Customer Name"; Customername)
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field("Sale Amount"; Rec."Sale Amount")
                {
                }
                field(Discount; Rec.Discount)
                {
                }
                field("Amount Payable"; Rec."Amount Payable")
                {
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = false;
                }
                field(Balance; Rec."Amount Payable" - Rec."Amount Paid")
                {
                    Editable = false;
                }
                field(Financier; Rec.Financier)
                {
                }
                field("Payment Option"; Rec."Payment Option")
                {
                }
                field("Payment Period"; Rec."Payment Period")
                {
                    Caption = 'Valid Field Offer Days';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                }
                field(Marketer; Rec.Marketer)
                {
                }
                field("Sale Date"; Rec."Sale Date")
                {
                }
                field("Is Active"; Rec."Is Active")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Customer.Get(Rec."Customer No") then
            Customername := Customer.Name;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if UserSetup."Sales Executive" = true then
            Rec.SetRange(Marketer, UserId);


        if (UserSetup."Sales Manager" = true) or (UserSetup."Branch Manager" = true) then begin
            if Rec.FindFirst then
                repeat

                    //REPEAT
                    if (Rec.Marketer = UserId) or (Rec."User Sales Manager" = UserId) or (Rec."User Branch Manager" = UserId) then
                        Rec.Mark(true);
                // END;
                until Rec.Next = 0;

            Rec.MarkedOnly(true);
        end;
    end;

    var
        Customer: Record Customer;
        Customername: Text;
        UserSetup: Record "User Setup";
}

