table 50081 "Plots Release"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Customer No"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
        }
        field(3; "Customer Name"; Text[140])
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Project Code"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
            trigger OnValidate()
            var
                Projects: Record Projects;
            begin
                if Projects.Get(Rec."Project Code") then begin
                    "Project Name" := Projects."Project Name";
                end;
            end;

        }

        field(5; "Project Name"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(6; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Plot Number"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots where(Project = field("Project Code"));

        }

        field(7; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(8; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(9; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


        field(12; "Sale Document"; Code[100])
        {
            TableRelation = "Plots Register".No where("Client Code" = field("Customer No"), "Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                PlotsReg: Record "Plots Register";
            begin

                PlotsReg.Reset();
                PlotsReg.SetRange(PlotsReg.No, Rec."Sale Document");
                if PlotsReg.FindFirst() then begin

                    "Plot Number" := PlotsReg."Plot No";
                    "Project Code" := PlotsReg.Project;

                end;
            end;
        }
        field(13; "No. Series"; Code[40])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        Noseries: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PlotsSetup: Record "Sacco No. Series";

    trigger OnInsert()
    begin
        if No = '' then begin
            PlotsSetup.Get();
            PlotsSetup.TestField("Plots Release");
            NoSeriesMgt.InitSeries(PlotsSetup."Plots Release", xRec."No. Series", 0D, No, "No. Series");
        end;
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