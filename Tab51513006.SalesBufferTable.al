table 51513006 "Sales Buffer Table"
{

    fields
    {
        field(1; "Sale ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Customer; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Sale Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Payable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Sale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sale,Offer;
        }
        field(16; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Posted;
        }
        field(18; "Sale Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Is Active"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = YES,NO;
        }
    }

    keys
    {
        key(Key1; "Sale ID", Customer)
        {
        }
    }

    fieldgroups
    {
    }
}

