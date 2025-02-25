page 51510220 "Plot Offers List"
{
    CardPageID = "Plot Offer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sale/Offer";
    SourceTableView = WHERE("Sale Type" = CONST(Offer),
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
                field("Customer Name"; Rec."Customer Name")
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
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    Visible = false;
                }
                field("Offer Expiry Date"; Rec."Offer Expiry Date")
                {
                }
                field(Marketer; Rec.Marketer)
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
        if UserSetup."Sales Executive" = true then begin
            Rec.FilterGroup(2);
            Rec.SetRange(Marketer, UserId);
            Rec.FilterGroup(0);
        end;

        /*IF (UserSetup."Sales Manager"=TRUE) OR (UserSetup."Branch Manager"=TRUE) THEN BEGIN
        IF Rec.FINDFIRST THEN
          REPEAT
        
        
            IF (Marketer=USERID) OR ("User Sales Manager"=USERID) OR("User Branch Manager"=USERID)  THEN
              Rec.MARK(TRUE);
            //END;
            UNTIL Rec.NEXT=0;
        
            Rec.MARKEDONLY(TRUE);
            END;*/


    end;

    var
        Customer: Record Customer;
        Customername: Text;
        UserSetup: Record "User Setup";
}

