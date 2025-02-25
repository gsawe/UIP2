table 50000 "Investment Employers"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Employer Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employer Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}