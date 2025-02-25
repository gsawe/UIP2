table 5151000 "Projects"
{

    fields
    {
        field(1; Name; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Code';
            TableRelation = "Due Diligence"."Project Code" where(Posted = filter(true));
            trigger Onvalidate()
            var
                myInt: Integer;
                Diligence: Record "Due Diligence";
            begin
                Diligence.Reset();
                Diligence.SetRange(Diligence."Project Code", Rec.Name);
                if Diligence.FindFirst() then begin
                    Rec."Project Size(Acres)" := Diligence."Parcel Size In Acres";
                    Rec."Initial Cost" := Diligence.Amount;
                    Rec."Project Name" := Diligence."Project Name";
                    Rec."Title No" := Diligence."Title No after Search";
                end;
            end;
        }
        field(2; Size; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Commision Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Percentage,Fixed';
            OptionMembers = ,Percentage,"Fixed";
        }
        field(4; "No of Plots"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Initial Cost Per Plot" := Rec."Initial Cost" / Rec."No of Plots";
            end;
        }
        field(5; "Plot Size"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Plot Sizes";
        }
        field(6; "Title No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Cost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Commision Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Plots Title Prefix"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Plots Title Suffix"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(13; "Plots Sold"; Integer)
        {
            CalcFormula = Count(Plots WHERE(Project = FIELD(Name),
                                             Availability = FILTER(Sold)));
            FieldClass = FlowField;
        }
        field(14; "Remaining Plots"; Integer)
        {
            CalcFormula = Count(Plots WHERE(Project = FIELD(Name),
                                             Availability = FILTER(Available)));
            FieldClass = FlowField;
        }
        field(15; "Plots Held"; Integer)
        {
            CalcFormula = Count(Plots WHERE(Project = FIELD(Name),
                                             Availability = FILTER(Held)));
            FieldClass = FlowField;
        }

        field(16; "Project Size(Acres)"; Decimal)
        {
            Editable = false;
        }

        field(17; "Initial Cost"; Decimal)
        {
            Editable = false;
        }
        field(18; "Discount Amount"; Decimal)
        {
            Editable = true;
        }
        field(19; "Initial Cost Per Plot"; Decimal)
        {
            Editable = false;
        }
        field(20; "Receivables Account"; Code[20])
        {
            Caption = 'Receivables Account';
            TableRelation = "G/L Account";
        }

        field(21; "Commission Receivable"; Code[20])
        {
            Caption = 'Commission Receivables Account';
            TableRelation = "G/L Account";
        }


        field(22; "Project Name"; Text[200])
        {
            Caption = 'Project Name';

        }
        field(23; "Vendor No"; Code[80])
        {
            Caption = 'Vendor No';
            TableRelation = Vendor."No.";

        }

        field(24; "Disposal Account"; Code[80])
        {
            Caption = 'Disposal Account"';
            TableRelation = "G/L Account"."No.";

        }
    }

    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; Name, "No of Plots", "Plots Sold")
        {
        }
    }

    trigger OnDelete()
    begin
        // Error('Delete is not allowed');
    end;

    var
        DueDiligence: Record "Due Diligence";
}

