table 51512299 "Title Processing"
{

    fields
    {
        field(1; "Title Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project Name"; Text[45])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Project Name" = CONST('')) Projects.Name;

            trigger OnValidate()
            begin
                Project.SetRange(Project.Name, "Project Name");
                if Project.FindFirst then begin
                    "Title Number" := Project."Title No";
                end;
                if Project.FindFirst then begin
                    "Project Size" := Project.Size;
                end;
            end;
        }
        field(3; "Title Number"; Code[100])
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
    }

    keys
    {
        key(Key1; "Title Code")
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
        GenSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: CodeuniT 396;
        Staff: Record Employee;
        Project: Record Projects;
}

