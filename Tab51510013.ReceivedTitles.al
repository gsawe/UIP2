table 51510013 "Received Titles"
{

    fields
    {
        field(1; "Title Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Received Titles"."Title Number";
        }
        field(2; "Project Name"; Text[45])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name;

            trigger OnValidate()
            begin

            end;
        }
        field(3; "Title Number"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Parcel Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Project Size"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Serial Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Good,Poor';
            OptionMembers = Good,Poor;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Approximate Area"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Plot Number"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" where(Project = field("Project Name"));
        }
        field(11; "Title Deed Number"; Code[250])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Member Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Member Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Title Code", "Title Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Title Code" = '' then begin
            GenSetup.Get;
            GenSetup.TestField(GenSetup."Title Nos");
            NoSeriesMgt.InitSeries(GenSetup."Title Nos", xRec."No. Series", 0D, "Title Code", "No. Series");
        end;
    end;

    var
        GenSetup: Record "Sacco No. Series";
        NoSeriesMgt: CodeuniT 396;
        Staff: Record Employee;
        Project: Record Projects;
}

