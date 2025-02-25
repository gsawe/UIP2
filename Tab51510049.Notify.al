table 51510049 "Notify"
{

    fields
    {
        field(1; "code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(3; Email; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Names; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "code", "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record Employee;
}

