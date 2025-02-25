table 51512297 "Categories of Rewards"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Categories of Rewards"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description of Reward"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Categories of Rewards", "Description of Reward")
        {
        }
    }
}

