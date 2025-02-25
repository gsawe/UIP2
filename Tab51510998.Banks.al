table 51510998 "Banks"
{
    DataClassification = ToBeClassified;
    LookupPageId = Banks;
    fields
    {
        field(1; "Bank Code"; Code[60])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Bank Name"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Bank Code")
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