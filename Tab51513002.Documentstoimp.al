table 51513002 "Documents to imp"
{

    fields
    {
        field(1; "Sale ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; url; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sale ID", url)
        {
        }
    }

    fieldgroups
    {
    }
}

