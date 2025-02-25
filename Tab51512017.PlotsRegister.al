table 51512017 "Plots Register"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; No; code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Client Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = filter(true));



            trigger Onvalidate()
            var
                Customers: Record Customer;
            begin
                Customers.Reset();
                Customers.SetRange(Customers."No.", Rec."Client Code");
                if Customers.FindFirst() then begin
                    "Client Name" := Customers.Name;
                end;
            end;
        }
        field(3; "Client Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(4; Project; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
            trigger OnValidate()
            var
                Projects: Record Projects;
            begin
                if Projects.Get(Rec.Project) then begin
                    "Project Name" := Projects."Project Name";
                end;
            end;
        }
        field(5; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots where(Project = field(Project));
            trigger Onvalidate()
            var
                Plots: Record Plots;
                PlotsR: Record "Plots Register";

            begin
                Plots.Reset();
                Plots.SetRange(Plots.Project, Project);
                Plots.SetRange(Plots."Plot No", "Plot No");
                if Plots.FindFirst() then begin
                    // Message('Hre%1', Plots.Price);
                    "Plot Amount" := Plots.Price;
                end;

                PlotsR.Reset();
                PlotsR.SetRange(PlotsR.Project, Project);
                PlotsR.SetRange(PlotsR."Plot No", "Plot No");
                PlotsR.SetRange(PlotsR.Posted, true);
                if PlotsR.FindFirst() then begin
                    Error('This plot is already taken.');
                end;

            end;
        }


        field(6; "Plot Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(7; "Record Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Outstanding Balance"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Plot Number" = field("Plot No"), "Project Name" = field(Project), "Transaction Type" = Filter(Plot | "Plot Repayment"), "Customer No." = field("Client Code"), Reversed = filter(false)));
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Plot Booked"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Outstanding Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Plot Number" = field("Plot No"), "Project Name" = field(Project), "Transaction Type" = Filter(Plot | "Plot Repayment"), "Customer No." = field("Client Code"), Reversed = filter(false)));
            FieldClass = FlowField;
        }

        field(13; "Correct Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }

        field(14; "Commission Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Project Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Original,Disposal;
            OptionCaption = 'Original,Disposal';
        }

        field(18; "Total Paid"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Plot Number" = field("Plot No"), "Project Name" = field(Project), "Transaction Type" = Filter("Plot Repayment"), "Customer No." = field("Client Code"), Reversed = filter(false)));
            FieldClass = FlowField;
        }

        field(19; "Plot Released"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            //   Clustered = true;
        }
        key(Key2; "Plot No")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, "Client Code", Project, "Plot No") { }
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
            PlotsSetup.TestField("Plots Purchase");
            NoSeriesMgt.InitSeries(PlotsSetup."Plots Purchase", xRec."No. Series", 0D, No, "No. Series");
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