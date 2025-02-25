table 51512006 "Receipts"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Customers.Get("Customer No") then begin
                    "Customer Name" := Customers.Name;
                    "User ID" := Customers.Marketer;
                    "User Sales Manager" := Customers."User Sales Manager";
                    "User Branch Manager" := Customers."User Branch Manager";

                end;

                // Employees.Reset;
                //  Employees.SetRange(Employees."User ID",UserId);
                //  if Employees.FindFirst then begin
                //  "Branch Code":=Employees."Global Dimension 1 Code";
                //  end;
            end;
        }
        field(2; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sale/Offer"."Project Code" WHERE("Customer No" = FIELD("Customer No"),
                                                               Status = CONST(Posted));

            trigger OnValidate()
            begin
                Validate("Plot No");
                Projects.Reset;
                Projects.SetRange(Projects.Name, "Project Code");
                if Projects.FindFirst then begin
                    "Branch Code" := Projects."Shortcut Dimension 1 Code";
                end;
            end;
        }
        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sale/Offer"."Plot No" WHERE("Customer No" = FIELD("Customer No"),
                                                          Status = CONST(Posted),
                                                          "Project Code" = FIELD("Project Code"));

            trigger OnValidate()
            begin
                SaleOffer.Reset;
                SaleOffer.SetRange(SaleOffer."Project Code", "Project Code");
                SaleOffer.SetRange(SaleOffer."Plot No", "Plot No");
                SaleOffer.SetRange(SaleOffer."Is Active", SaleOffer."Is Active"::YES);
                if SaleOffer.FindFirst then begin
                    "User ID" := SaleOffer.Marketer;
                end;
            end;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Plot No");
            end;
        }
        field(5; "Payment Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Mpesa,Bank,Cheque,"Wire Transfer",Cash,Transfer;
        }
        field(6; "Reference Code"; Code[500])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                Validate("Plot No");
            end;

            trigger OnValidate()
            begin
                Receipt.Reset;
                Receipt.SetRange(Receipt."Customer No", "Customer No");
                Receipt.SetRange(Receipt."Branch Code", "Branch Code");
                Receipt.SetRange(Receipt."Plot No", "Plot No");
                Receipt.SetRange(Receipt."Reference Code", "Reference Code");
                if Receipt.FindFirst then begin
                    Error('This payment already exists.');
                end;
            end;
        }
        field(7; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Payment Date" > Today then
                    Error('payment date cannot be in the future');
            end;
        }
        field(8; Comment; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Posted;
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
        field(24; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(25; "Branch Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "External Doc No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(28; "Is Active"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = YES,NO;
        }
        field(29; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Canceled,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Canceled,Rejected;
        }
        field(30; "Customer Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Plot Value"; Decimal)
        {
            CalcFormula = Lookup("Sale/Offer"."Sale Amount" WHERE("Customer No" = FIELD("Customer No"),
                                                                   "Plot No" = FIELD("Plot No")));
            FieldClass = FlowField;
        }
        field(32; "Date Recorded"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Approved By"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; Staff; Boolean)
        {
            CalcFormula = Lookup(Customer.Staff WHERE("No." = FIELD("Customer No")));
            FieldClass = FlowField;
        }
        field(37; Inactive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "From Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(39; "From Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("From Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Account Type" = CONST(Posting),
                                                                                                     Blocked = CONST(false))
            ELSE IF ("From Account Type" = CONST("Bank Account")) "Bank Account"."No."
            ELSE IF ("From Account Type" = CONST(Vendor)) Vendor."No."
            ELSE IF ("From Account Type" = CONST(Customer)) Customer."No.";
        }
        field(40; "To Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(41; "To Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("To Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Account Type" = CONST(Posting),
                                                                                                   Blocked = CONST(false))
            ELSE IF ("To Account Type" = CONST("Bank Account")) "Bank Account"."No."
            ELSE IF ("To Account Type" = CONST(Customer)) Customer."No."
            ELSE IF ("To Account Type" = CONST(Vendor)) Vendor."No.";
        }
        field(42; "Receipt Posted(Fin)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Finance Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Finance Posted By"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", "Plot No", "Key", "Project Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserSetups.Get(UserId);
        if UserSetups.Administrator = false then begin
            Error('Delete is not allowed');
        end;
    end;

    trigger OnInsert()
    begin
        // IF UserSetup.GET(USERID) THEN BEGIN
        //
        // END ELSE BEGIN
        // ERROR('You have not been setup as a user in the system');
        // END;
        //  Employees.Reset;
        //  Employees.SetRange(Employees."User ID",UserId);
        //  if Employees.FindFirst then begin
        //  "Branch Code":=Employees."Global Dimension 1 Code";
        //  end;
        //  "Date Recorded":=Today;

        //  if UserSetups.Get(UserId) then begin
        //  if UserSetups.Manager=true then
        //  Manager:=true;
        //  end;
    end;

    trigger OnModify()
    begin
        if "Receipt Posted(Fin)" = true then
            Error('Modify is not allowed');
    end;

    var
        UserSetup: Record "User Setup";
        Customers: Record Customer;
        Employees: Record Employee;
        Receipt: Record Receipts;
        SaleOffer: Record "Sale/Offer";
        UserSetups: Record "User Setup";
        Projects: Record Projects;
}

