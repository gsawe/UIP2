table 51510050 "Plots Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Client Code"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Project Code"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Correct Plot No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Migrated Correct Plots"; Code[40])
        {
            DataClassification = ToBeClassified;

        }

        field(6; "Document Number"; Code[60])
        {
            DataClassification = ToBeClassified;

        }





    }

    keys
    {
        key(Key1; "Client Code", "Project Code", "Plot No")
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