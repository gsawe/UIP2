table 51513004 "Contact Person Sales"
{
    LookupPageID = "Contact Person";

    fields
    {
        field(1; "Document Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Contact; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Relationship; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Spouse,Father,Mother,Brother,Sister,Son,Daughter,Nephew,Niece,Other';
            OptionMembers = ,Spouse,Father,Mother,Brother,Sister,Son,Daughter,Nephew,Niece,Other;
        }
        field(5; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Plot Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Number", Name, "Project Code", "Plot Number")
        {
        }
    }

    fieldgroups
    {
    }
}

