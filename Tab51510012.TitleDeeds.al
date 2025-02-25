table 51510012 "Title Deeds"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Project Name"; Code[120])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name;
        }

        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" where(Project = field("Project Name"));
        }

        field(4; "Title Deed No"; Code[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(5; "Title Location"; Option)
        {
            OptionMembers = "Utabibu Office","Issued To Parcel Owner",Surrendered,"Under Processing","Collected-Washed","Office-Washed",Correction;
            OptionCaption = '"Utabibu Office","Issued To Parcel Owner",Surrendered,Under Processing,"Collected-Washed","Office-Washed",Correction';
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(6; "Issued To"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = const(true));
            trigger Onvalidate()
            var
                Cust: record Customer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "Issued To");
                if Cust.FindFirst() then begin
                    Rec."Issued To Name" := Cust.Name;
                end;
            end;

        }

        field(7; "Issued To Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(8; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(9; "Issued By"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(10; "No. Series"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Place Of Issue"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(12; Issued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Received Title Document"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Received Titles"."Title Code" where("Project Name" = field("Project Name"), "Plot Number" = field("Plot No"));
            trigger Onvalidate()
            var
                RecievedTitle: Record "Received Titles";
            begin
                RecievedTitle.Reset();
                RecievedTitle.SetRange(RecievedTitle."Title Code", "Received Title Document");
                if RecievedTitle.FindFirst() then begin
                    Rec."Title Deed No" := RecievedTitle."Title Deed Number";
                end;
            end;
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

    trigger OnInsert()
    begin
        if Rec.No = '' then begin
            GenSetup.Get;
            GenSetup.TestField(GenSetup."Process Nos");
            NoSeriesMgt.InitSeries(GenSetup."Process Nos", xRec."No. Series", 0D, Rec.No, "No. Series");
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

    var
        Staff: Record Employee;
        GenSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TL: Record "Title Processing";
        PlotsSetup: Record "Sacco No. Series";
}