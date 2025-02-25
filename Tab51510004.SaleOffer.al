table 51510004 "Sale/Offer"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Customer No");
                if Cust.FindFirst then begin
                    "Joint Name" := Cust.Name;
                end;
                Validate("Plot No");
            end;
        }
        field(2; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name WHERE("Remaining Plots" = FILTER(<> 0));

            trigger OnValidate()
            begin
                Projects.Get("Project Code");
                "Shortcut Dimension 1 Code" := Projects."Shortcut Dimension 1 Code";
                // VALIDATE("Plot No");
            end;
        }
        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" WHERE(Project = FIELD("Project Code"),
                                                   Availability = FILTER(Available));

            trigger OnValidate()
            begin
                CalcFields("Similar Plots");
                Sale.Reset;
                Sale.SetRange(Sale."Project Code", "Project Code");
                Sale.SetRange(Sale."Plot No", "Plot No");
                Sale.SetRange(Sale."Customer No", "Customer No");
                if Sale.FindFirst then begin
                    Sale.CalcFields(Sale."Similar Plots");
                    //MESSAGE('Plots%1',Sale."Similar Plots");
                    if Sale."Similar Plots" > 0 then begin
                        Error('Plot already taken.');
                    end;
                end;

                Plots.Reset;
                Plots.SetRange(Project, "Project Code");
                Plots.SetRange("Plot No", "Plot No");
                if Plots.FindFirst then begin
                    if Plots.Availability <> Plots.Availability::Available then
                        Error('The selected plot is not available.');
                end;



                Plots.Reset;
                Plots.SetRange(Project, "Project Code");
                Plots.SetRange("Plot No", "Plot No");
                if Plots.FindFirst then begin
                    "Sale Amount" := Plots.Price;
                    "Amount Payable" := Plots.Price;
                end;
            end;
        }
        field(4; "Sale Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount Payable" := "Sale Amount" - Discount;
            end;
        }
        field(5; Discount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount Payable" := "Sale Amount" - Discount;
            end;
        }
        field(6; "Amount Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Financier; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Financiers;
        }
        field(8; "Payment Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Cash,Installments;
        }
        field(9; "Payment Period"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Sale Type" = "Sale Type"::Offer then begin
                    "Offer Expiry Date" := CalcDate(Format("Payment Period") + 'D', "Offer Start Date");
                    "Amount Payable" := "Sale Amount";
                end;

                if "Sale Type" = "Sale Type"::Sale then begin
                    "Completion Date" := CalcDate('+' + Format("Payment Period") + 'M');
                    "Installment Interest" := 0;
                    if "Payment Period" > 3 then begin
                        "Payment Option" := "Payment Option"::Installments;
                        "Installment Interest" := 10000 * ("Payment Period" - 3);
                        "Amount Payable" := ("Sale Amount" + "Installment Interest") - Discount;
                    end else begin
                        "Payment Option" := "Payment Option"::Cash;
                        "Amount Payable" := "Sale Amount" - Discount;
                    end;
                end;
            end;
        }
        field(10; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Offer Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Sale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sale,Offer;

            trigger OnValidate()
            begin
                if "Sale Type" = "Sale Type"::Sale then
                    "Sale Date" := Today;
                if "Sale Type" = "Sale Type"::Offer then
                    "Offer Date" := Today;
            end;
        }
        field(13; Marketer; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(14; "Amount Paid"; Decimal)
        {
            CalcFormula = Sum(Receipts.Amount WHERE("Customer No" = FIELD("Customer No"),
                                                     "Project Code" = FIELD("Project Code"),
                                                     "Plot No" = FIELD("Plot No"),
                                                     Status = CONST(Posted),
                                                     "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(16; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Posted;
        }
        field(17; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(18; "Sale Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Offer Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Installment Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(22; "User Sales Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(23; "User Branch Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(24; "Sale ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Is Active"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = YES,NO;
        }
        field(26; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Canceled,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Canceled,Rejected;
        }
        field(27; "Joint Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Joint ID"; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Joint Telephone"; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Joint Sale"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Sales Agreement Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Terms and Conditions"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Schedule Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Plan".Amount WHERE("Customer No" = FIELD("Customer No"),
                                                           "Project Code" = FIELD("Project Code"),
                                                           "Plot No" = FIELD("Plot No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Agreement Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Commission At"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Offer Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Similar Plots"; Integer)
        {
            CalcFormula = Count("Sale/Offer" WHERE("Project Code" = FIELD("Project Code"),
                                                    "Plot No" = FIELD("Plot No"),
                                                    "Is Active" = CONST(YES)));
            FieldClass = FlowField;
        }
        field(39; "Customer Name"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", "Sale Type", "Project Code", "Plot No", No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Delete is not allowed');
    end;

    trigger OnInsert()
    begin
        UserSetup.Get(UserId);
        Marketer := UserSetup."User ID";
        "User Sales Manager" := UserSetup."User Sales Manager";
        "User Branch Manager" := UserSetup."User Branch Manager";
    end;

    trigger OnModify()
    begin
        // IF Status=Status::Posted THEN
        // ERROR('Modify is not allowed');
    end;

    var
        UserSetup: Record "User Setup";
        Plots: Record Plots;
        Projects: Record Projects;
        Sale: Record "Sale/Offer";
        Cust: Record Customer;
}

