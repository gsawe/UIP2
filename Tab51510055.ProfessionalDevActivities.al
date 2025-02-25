table 51510055 "Professional Dev Activities"
{

    fields
    {
        field(1; "Appraisal Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appraisal Code", "Employee No", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

