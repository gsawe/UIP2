table 51512018 "Due Diligence"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Parcel Owner"; Text[120])
        {
            DataClassification = ToBeClassified;

        }

        field(3; "Parcel Size In Acres"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Parcel Size In words"; Text[200])
        {
            DataClassification = ToBeClassified;

        }

        field(5; "Parcel Location"; Text[200])
        {
            DataClassification = ToBeClassified;

        }

        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(7; "Title No"; Text[150])
        {
            DataClassification = ToBeClassified;

        }

        field(8; "Status"; Option)
        {
            OptionCaption = 'Open,"Pending Approval",Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
            DataClassification = ToBeClassified;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Project Name"; Text[350])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "No. Series"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Record Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Due Diligence Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Registration,Search,Project;
            OptionCaption = 'Registration,Search,Project';
        }
        field(14; "Search Conducted By?"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Search Office"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Owner after search"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Parcel Size after search"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Caveat"; Text[2000])
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Cost Per Acre"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if Rec."Parcel Type" = Rec."Parcel Type"::Plots then begin
                    Rec.TestField("Number Of Plots");
                    Amount := "Number Of Plots" * "Cost Per Plot";
                end else
                    if Rec."Parcel Type" = Rec."Parcel Type"::"Land Mass" then begin
                        Rec.TestField("Parcel Size In Acres");
                        Amount := "Parcel Size In Acres" * "Cost Per Acre";
                    end;
            end;
        }
        field(20; "Number Of Plots"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Cost Per Plot"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if Rec."Parcel Type" = Rec."Parcel Type"::Plots then begin
                    Rec.TestField("Number Of Plots");
                    Amount := "Number Of Plots" * "Cost Per Plot";
                end else
                    if Rec."Parcel Type" = Rec."Parcel Type"::"Land Mass" then begin
                        Rec.TestField("Parcel Size In Acres");
                        Amount := "Parcel Size In Acres" * "Cost Per Acre";
                    end;
            end;
        }

        field(22; "Parcel Type"; Option)
        {
            OptionMembers = ,"Land Mass",Plots;
            OptionCaption = ',Land Mass,Plots';
            DataClassification = ToBeClassified;
        }
        field(23; "Title No after Search"; Text[150])
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(Key1; No, "Title No", "Project Code")
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
            PlotsSetup.TestField("Diligence Nos");
            NoSeriesMgt.InitSeries(PlotsSetup."Diligence Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Record Date" := Today;
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