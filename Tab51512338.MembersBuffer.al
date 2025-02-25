table 51512338 "Members Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[40])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Employee Id"; Code[40])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Member No")
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