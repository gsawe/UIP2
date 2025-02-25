page 51510216 "Plot Sales/Offers List"
{
    CardPageID = "Plot Sales/Offer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sale/Offer";
    SourceTableView = WHERE("Is Active" = CONST(YES));

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
                }
                field("Completion Date"; Rec."Completion Date")
                {
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
        Customer.Get(Rec."Customer No");
        Customername := Customer.Name;
    end;

    var
        Customer: Record Customer;
        Customername: Text;
}

