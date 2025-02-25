table 51512057 "Financiers"
{
    DrillDownPageID = Financiers;
    LookupPageID = Financiers;

    fields
    {
        field(1; "code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "code")
        {
        }
    }

    fieldgroups
    {
    }
}

