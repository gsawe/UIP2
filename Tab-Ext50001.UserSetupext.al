tableextension 50001 "User Setup ext" extends "User Setup"
{
    //Caption = 'User Setup';
    // DrillDownPageID = "User Setup";


    fields
    {

        field(5901; "Plot hold days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Allow Plot Details Change"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "PLot Holding"; Boolean)
        {
            Caption = 'Plot Release';
            DataClassification = ToBeClassified;
        }
        field(50003; Administrator; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "User Sales Manager"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(50006; "User Branch Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Branch Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Sales Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Sales Executive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Staff Travel Account"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Allow Process Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Member Registration"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Is Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Archiving User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Petty C Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Post Pv"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "Journal Batch Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Journal Template Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        NotificationSetup: Record "Notification Setup";
    begin
        NotificationSetup.SetRange("User ID", "User ID");
        NotificationSetup.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        User: Record User;
    begin
        if "E-Mail" <> '' then
            exit;
        if "User ID" <> '' then
            exit;
        User.SetRange("User Name", "User ID");
        if User.FindFirst then
            "E-Mail" := CopyStr(User."Contact Email", 1, MaxStrLen("E-Mail"));
    end;

    var
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: Label 'You cannot have both a %1 and %2. ';
        Text005: Label 'You cannot have approval limits less than zero.';
        SalesPersonPurchaser: Record "Salesperson/Purchaser";
        PrivacyBlockedGenericErr: Label 'Privacy Blocked must not be true for Salesperson / Purchaser %1.', Comment = '%1 = salesperson / purchaser code.';
        UserSetupManagement: Codeunit "User Setup Management";


}

