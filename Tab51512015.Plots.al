table 51512015 "Plots"
{
    DrillDownPageID = Plots;
    LookupPageID = Plots;

    fields
    {
        field(1; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Size; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Plot Sizes";
        }
        field(3; "Title No"; Code[100])
        {
            Editable = false;
            Caption = 'Series No';
            DataClassification = ToBeClassified;
        }
        field(4; Price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Availability; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Available,Held,Sold;
        }
        field(6; Project; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(7; "Held By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sold By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Released By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Client Name"; Text[80])
        {
            CalcFormula = Lookup("Sale/Offer"."Joint Name" WHERE("Project Code" = FIELD(Project),
                                                                  "Plot No" = FIELD("Plot No"),
                                                                  "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(11; "Sale Date"; Date)
        {
            CalcFormula = Lookup("Sale/Offer"."Sale Date" WHERE("Project Code" = FIELD(Project),
                                                                 "Plot No" = FIELD("Plot No"),
                                                                 "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(12; "Amount Payable"; Decimal)
        {
            CalcFormula = Lookup("Sale/Offer"."Amount Payable" WHERE("Project Code" = FIELD(Project),
                                                                      "Plot No" = FIELD("Plot No"),
                                                                      "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(13; "Customer Id"; Code[40])
        {
            CalcFormula = Lookup("Sale/Offer"."Customer No" WHERE("Project Code" = FIELD(Project),
                                                                   "Plot No" = FIELD("Plot No"),
                                                                   "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(14; "ID Number"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Comment; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Held Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Released Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Paid Amount"; Decimal)
        {
            CalcFormula = Sum(Receipts.Amount WHERE("Project Code" = FIELD(Project),
                                                     "Plot No" = FIELD("Plot No"),
                                                     Status = CONST(Posted)));
            FieldClass = FlowField;
        }
        field(19; "Sale Created Date"; Date)
        {
            CalcFormula = Lookup("Sale/Offer"."Created Date" WHERE("Customer No" = FIELD("Customer Id"),
                                                                    "Project Code" = FIELD(Project),
                                                                    "Plot No" = FIELD("Plot No")));
            FieldClass = FlowField;
        }
        field(20; Name; Text[100])
        {
            CalcFormula = Lookup(Receipts."Customer Name" WHERE("Plot No" = FIELD("Plot No"),
                                                                 "Project Code" = FIELD(Project),
                                                                 Amount = FILTER(> 0),
                                                                 Inactive = FILTER(false)));
            FieldClass = FlowField;
        }

        field(21; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Plot Number" = field("Plot No"), "Transaction Type" = filter("Plot Repayment" | Plot), "Project Name" = field(Project)));
            FieldClass = FlowField;
        }
        field(22; "Title Deed No"; Code[200])
        {
            Caption = 'Title Deed No';
        }

        field(23; "Project Name"; Text[200])
        {
            Caption = 'Project Name';
        }

        field(24; "Member Name"; Text[200])
        {
            CalcFormula = lookup("Plots Register"."Client Name" where(Project = field(Project), "Plot No" = field("Plot No"), Posted = filter(true)));
            FieldClass = FlowField;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Plot No", Project)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Plot No", "Title No")
        {
        }
    }

    trigger OnDelete()
    begin
        Error('Delete is not allowed');
    end;
}

