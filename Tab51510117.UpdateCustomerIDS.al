table 51510117 "Update Customer IDS"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(2; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "Customer No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
        UserSetup: Record "User Setup";
}

