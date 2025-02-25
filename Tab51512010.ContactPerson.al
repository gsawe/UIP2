table 51512010 "Contact Person"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Relationship; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", Name)
        {
        }
    }

    fieldgroups
    {
    }
}

