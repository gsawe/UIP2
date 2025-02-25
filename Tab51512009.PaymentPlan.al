table 51512009 "Payment Plan"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(2; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", "Project Code", "Plot No", Date)
        {
        }
    }

    fieldgroups
    {
    }
}

