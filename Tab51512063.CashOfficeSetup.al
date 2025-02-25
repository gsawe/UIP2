//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51512063 "Cash Office Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(515102001; "Normal Payments No"; Code[10])
        {
            Caption = 'Normal Payments No';
            TableRelation = "No. Series";
        }
        field(515102002; "Cheque Reject Period"; DateFormula)
        {
        }
        field(515102003; "Petty Cash Payments No"; Code[10])
        {
            Caption = 'Petty Cash Payments No';
            TableRelation = "No. Series";
        }
        field(515102004; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(515102005; "Current Budget Start Date"; Date)
        {
        }
        field(515102006; "Current Budget End Date"; Date)
        {
        }
        field(515102009; "Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(515102010; "Surrender  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Surrender Template"));
        }
        field(515102011; "Payroll Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(515102012; "Payroll  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(515102013; "Payroll Control A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(515102014; "PV Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(515102015; "PV  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(515102016; "Contract No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102017; "Receipts No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102018; "Petty Cash Voucher  Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(515102019; "Petty Cash Voucher Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(515102020; "Max. Petty Cash Request"; Decimal)
        {
        }
        field(515102022; "Imprest Req No"; Code[20])
        {
            Caption = 'Receipts No';
            TableRelation = "No. Series";
        }
        field(515102023; "Quotation Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102024; "Tender Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102025; "Transport Pay Type"; Code[20])
        {
        }
        field(515102026; "Minimum Chargeable Weight"; Decimal)
        {
        }
        field(515102027; "Imprest Surrender No"; Code[20])
        {
            Caption = 'Imprest Surrender No';
            TableRelation = "No. Series";
        }
        field(515102028; "Bank Deposit No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102029; "InterBank Transfer No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(515102030; "PA Payment Vouchers Nos"; Code[20])
        {
            Caption = 'Farmers Payment Vouchers Nos.';
            TableRelation = "No. Series".Code;
        }
        field(515102031; "Cash Request Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(515102032; "Cash Issue Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(515102033; "Cash Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(515102034; "Cash Transfer Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(515102035; "Cash Transfer Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cash Transfer Template"));
        }
        field(515102036; "Enable AutoTeller Monitor"; Boolean)
        {
        }
        field(515102037; "Alert After ?(Mins)"; Integer)
        {
        }
        field(515102038; "Transporter Depot"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(515102039; "Transporter Department"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(515102040; "Transporter Cashier"; Code[20])
        {
            TableRelation = "Cash Office User Template";
        }
        field(515102041; "Transporter PayType"; Code[20])
        {
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Payment));
        }
        field(515102042; "Cashier Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(515102043; "Interim Transfer Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(515102044; "Default Bank Deposit Slip A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(515102045; "Apply Cash Expenditure Limit"; Boolean)
        {
        }
        field(515102046; "Expenditure Limit Amount(LCY)"; Decimal)
        {
        }
        field(51512050; "Staff Claim No."; Code[20])
        {
            Caption = 'Staff Claim No';
            TableRelation = "No. Series";
        }
        field(51512051; "Other Staff Advance No."; Code[20])
        {
            Caption = 'Other Staff Advance No';
            TableRelation = "No. Series";
        }
        field(51512052; "Staff Advance Surrender No."; Code[20])
        {
            Caption = 'Staff Adv. Surrender No';
            TableRelation = "No. Series";
        }
        field(51512053; "Prompt Cash Reimbursement"; Boolean)
        {
        }
        field(515102054; "Use Central Payment System"; Boolean)
        {
        }
        field(51512060; "Payment Request Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51512061; "Journal Voucher Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172070; "Minimum Cheque Creation Amount"; Decimal)
        {
            Description = 'Starting Amount to create a check';
        }
        field(172071; "Grant Surrender Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172072; "Cash Purchases"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172073; "Board Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172074; "Committee Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172075; "Board PV Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172076; "Committee PV Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172077; "Cash Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172078; "Cheque Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172079; "MPESA Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172080; "Airtel Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172081; "Mobile Money Payment Nos"; Code[20])
        {
        }
        field(172082; "Casual Req. No's"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




