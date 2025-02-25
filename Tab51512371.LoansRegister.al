//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51512371 "Loans Register"
{
    // DrillDownPageId = "Loans  List All";
    // LookupPageId = "Loans  List All";

    fields
    {
        field(1; "Loan  No."; Code[30])
        {

        }
        field(2; "Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error('Application date can not be in the future.');
            end;
        }
        field(3; "Loan Product Type"; Code[50])
        {

        }
        field(4; "Client Code"; Code[50])
        {
        }
        field(5; "Group Code"; Code[5])
        {
        }
        field(6; Savings; Decimal)
        {
            Editable = false;
        }
        field(7; "Existing Loan"; Decimal)
        {
            Editable = false;
        }
        field(8; "Requested Amount"; Decimal)
        {
        }
        field(9; "Approved Amount"; Decimal)
        {
        }
        field(16; Interest; Decimal)
        {
        }
        field(17; Insurance; Decimal)
        {
            Editable = false;
        }
        field(21; "Source of Funds"; Code[5])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                GLSetup.Get;
                Dimension := GLSetup."Shortcut Dimension 3 Code";
            end;
        }
        field(22; "Client Cycle"; Integer)
        {
            Editable = false;
        }
        field(26; "Client Name"; Text[100])
        {
            Editable = false;
        }

        field(29; "Issued Date"; Date)
        {
        }
        field(30; Installments; Integer)
        {

            trigger OnValidate()
            begin
                //if Posted <> true then begin
                //if Installments > "Max. Installments" then
                //    Error('Installments cannot be greater than the maximum installments.');
                //end;

                Validate("Approved Amount");

                GenSetUp.Get();
                if Cust.Get("Client Code") then begin
                    if (Cust."Date of Birth" <> 0D) and ("Application Date" <> 0D) and (Installments > 0) then begin
                        if CalcDate(Format(Installments) + 'M', "Application Date") > CalcDate(GenSetUp."Retirement Age", Cust."Date of Birth") then
                            if Confirm('Member due to retire before loan repayment is complete. Do you wish to continue?') = false then
                                Installments := 0;

                    end;
                end;

                //"Expected Date of Completion":=CALCDATE(FORMAT(Installments)+'M',"Issued Date");


                FnUpdateRepaymentAmount();
            end;
        }
        field(34; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                "Issued Date" := "Loan Disbursement Date";

                GenSetUp.Get;
                //
                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Loan Disbursement Date", 2);
                DAY := Date2dmy("Loan Disbursement Date", 1);


                StartDate := Dmy2date(1, Month, currYear); // StartDate will be the date of the first day of the month

                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;

                end;


                //===========================================================Get Repayment Start Date
                GenSetUp.Get;
                VarLoanDisburesementDay := Date2dmy("Loan Disbursement Date", 1);

                if VarLoanDisburesementDay > GenSetUp."Last Date of Checkoff Advice" then
                    "Repayment Start Date" := CalcDate('CM', (CalcDate('1M', "Loan Disbursement Date")))
                else
                    "Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date");


                EndDate := Dmy2date(1, Month + 1, currYear) - 1;

                //IF DAY <=23 THEN BEGIN
                //"Repayment Start Date":=CALCDATE("Loan Disbursement Date");
                //END ELSE BEGIN
                //"Repayment Start Date":=CALCDATE('1M',"Loan Disbursement Date");
                //END;
                //"Expected Date of Completion":=CALCDATE('CM',CALCDATE('CM+1M',"Loan Disbursement Date")); TODO
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Repayment Start Date");
            end;
        }
        field(35; "Mode of Disbursement"; Option)
        {
            OptionCaption = ' ,Cheque,FOSA Account,EFT,RTGS,Cheque NonMember,Bank Transfer';
            OptionMembers = " ",Cheque,"FOSA Account",EFT,RTGS,"Cheque NonMember","Bank Transfer";

            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "mode of disbursement"::"FOSA Account" then begin
                    TestField("Account No");
                end;
            end;
        }
        field(53; "Affidavit - Item 1 Details"; Text[20])
        {
        }
        field(54; "Affidavit - Estimated Value 1"; Decimal)
        {
        }
        field(55; "Affidavit - Item 2 Details"; Text[20])
        {
        }
        field(56; "Affidavit - Estimated Value 2"; Decimal)
        {
        }
        field(57; "Affidavit - Item 3 Details"; Text[20])
        {
        }
        field(58; "Affidavit - Estimated Value 3"; Decimal)
        {
        }
        field(59; "Affidavit - Item 4 Details"; Text[20])
        {
        }
        field(60; "Affidavit - Estimated Value 4"; Decimal)
        {
        }
        field(61; "Affidavit - Item 5 Details"; Text[20])
        {
        }
        field(62; "Affidavit - Estimated Value 5"; Decimal)
        {
        }
        field(63; "Magistrate Name"; Text[30])
        {
        }
        field(64; "Date for Affidavit"; Date)
        {
        }
        field(65; "Name of Chief/ Assistant"; Text[30])
        {
        }
        field(66; "Affidavit Signed?"; Boolean)
        {
        }
        field(67; "Date Approved"; Date)
        {
        }
        field(53048; "Grace Period"; DateFormula)
        {
        }
        field(53049; "Instalment Period"; DateFormula)
        {
        }
        field(53051; "Pays Interest During GP"; Boolean)
        {
        }
        field(53053; "Percent Repayments"; Decimal)
        {
            Editable = false;
        }
        field(53054; "Paying Bank Account No"; Code[25])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(53055; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(53056; "Loan Product Type Name"; Text[100])
        {
        }
        field(53057; "Cheque Number"; Code[25])
        {

            trigger OnValidate()
            begin
                /*Loan.RESET;
                
                Loan.SETRANGE(Loan."Cheque Number","Cheque Number");
                Loan.SETRANGE(Loan."Bela Branch","Bela Branch");
                IF Loan.FIND('-') THEN BEGIN
                IF Loan."Cheque Number"="Cheque Number" THEN
                ERROR('The Cheque No. has already been used');
                END; */

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then begin
                        if Loan."Cheque No." <> "Cheque No." then
                            Error('"Cheque No.". already exists');
                    end;
                end;

            end;
        }
        field(53058; "Bank No"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Bank Account"."No.";
        }
        field(53059; "Slip Number"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53060; "Total Paid"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(53061; "Schedule Repayments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53062; "Doc No Used"; Code[20])
        {
        }
        field(53063; "Posting Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53065; "Batch No."; Code[20])
        {
            Editable = true;
            FieldClass = Normal;
            TableRelation = if (Posted = const(false)) "Loan Disburesment-Batching"."Batch No."
            else
            if (Posted = const(true)) "Loan Disburesment-Batching"."Batch No.";

            trigger OnValidate()
            begin

                if "Loan Product Type" <> 'FL353' then begin
                    RepaySched.Reset;
                    RepaySched.SetRange(RepaySched."Loan No.", "Loan  No.");
                    if not RepaySched.Find('-') then
                        Error('Loan Schedule must be generated and confirmed before loan is attached to batch');

                end;
                if "Batch No." <> '' then begin
                    if "Loan Product Type" = '' then
                        Error('You must specify Loan Product Type before assigning a loan a Batch No.');

                end;
                if "Approval Status" = "approval status"::Open then
                    Error('You Can Only Batch Loans Sent for Approval');

            end;
        }
        field(53066; "Edit Interest Rate"; Boolean)
        {
        }
        field(53067; Posted; Boolean)
        {
            Editable = true;
        }
        field(53068; "Product Code"; Code[25])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                GLSetup.Get;
                Dimension := GLSetup."Shortcut Dimension 3 Code";
            end;
        }
        field(53077; "Document No 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53078; "Field Office"; Code[5])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FIELD OFFICE'));
        }
        field(53079; Dimension; Code[20])
        {
        }
        field(53080; "Amount Disbursed"; Decimal)
        {
        }
        field(53081; "Fully Disbursed"; Boolean)
        {
        }
        field(53082; "New Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(53083; "New No. of Instalment"; Integer)
        {
            Editable = false;
        }
        field(53084; "New Grace Period"; DateFormula)
        {
            Editable = false;
        }
        field(53085; "New Regular Instalment"; DateFormula)
        {
            Editable = false;
        }
        field(53086; "Loan Balance at Rescheduling"; Decimal)
        {
            Editable = false;
        }
        field(53087; "Loan Reschedule"; Boolean)
        {
        }
        field(53088; "Date Rescheduled"; Date)
        {
        }
        field(53089; "Reschedule by"; Code[20])
        {
        }
        field(53090; "Flat Rate Principal"; Decimal)
        {
        }
        field(53091; "Flat rate Interest"; Decimal)
        {
        }
        field(53092; "Total Repayment"; Decimal)
        {
            Editable = false;
        }
        field(53093; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(53094; "Edit Interest Calculation Meth"; Boolean)
        {
        }
        field(53095; "Balance BF"; Decimal)
        {
        }
        field(53098; "Interest to be paid"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Member No." = field("Client Code"),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53099; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53101; "Cheque Date"; Date)
        {
        }
        field(172300; "Outstanding Balance"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
            //                                                       "Transaction Type" = filter(Loan | repayment),
            //                                                       "Currency Code" = field("Currency Filter"),
            //                                                       "Posting Date" = field("Date filter")));
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."), "Customer No." = field("Client Code"),
            //                                                     Reversed = filter(false),
            //                                                       "Transaction Type" = filter(Repayment | Loan),
            //                                                       "Posting Date" = field("Date Filter")));
            // Editable = false;
            // FieldClass = FlowField;

            //  CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."), "Transaction Type" = filter(Loan | Repayment)));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                // Message('Outbal %1', "Outstanding Balance");
            end;
        }
        field(53103; "Loan to Share Ratio"; Decimal)
        {
        }
        field(53104; "Shares Balance"; Decimal)
        {
            Editable = false;
        }
        field(53105; "Max. Installments"; Integer)
        {
            Editable = false;
        }
        field(53106; "Max. Loan Amount"; Decimal)
        {
            Editable = false;
        }
        field(53107; "Loan Cycle"; Integer)
        {
            Editable = false;
        }
        field(53108; "Penalty Charged"; Decimal)
        {

        }
        field(53109; "Loan Amount"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter("Shares Capital"),
                                                                              "Loan No" = field("Loan  No.")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(53110; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53111; "Loan Repayment"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter("Interest Paid"),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(53112; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;

            trigger OnValidate()
            begin
                Validate("Approved Amount");
            end;
        }
        field(53113; "Grace Period - Principle (M)"; Integer)
        {

            trigger OnValidate()
            begin
                //Installments:="Installment Including Grace"-"Grace Period - Principle (M)"
            end;
        }
        field(53114; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(53115; Adjustment; Text[80])
        {
        }
        field(53116; "Payment Due Date"; Text[80])
        {
        }
        field(53117; "Tranche Number"; Integer)
        {
        }
        field(53118; "Amount Of Tranche"; Decimal)
        {
        }
        field(53119; "Total Disbursment to Date"; Decimal)
        {
        }
        field(53133; "Copy of ID"; Boolean)
        {
        }
        field(53134; Contract; Boolean)
        {
        }
        field(53135; Payslip; Boolean)
        {
        }
        field(53136; "Contractual Shares"; Decimal)
        {
        }
        field(53182; "Last Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Plot Repayment")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53183; "Interest Due"; Decimal)
        {

        }
        field(53184; "Appraisal Status"; Option)
        {
            OptionCaption = 'Expresion of Interest,Desk Appraisal,Loan form purchased,Loan Officer Approved,Management Approved,Credit Subcommitee Approved,Trust Board Approved';
            OptionMembers = "Expresion of Interest","Desk Appraisal","Loan form purchased","Loan Officer Approved","Management Approved","Credit Subcommitee Approved","Trust Board Approved";
        }
        field(53185; "Interest Paid"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                               "Loan No" = field("Loan  No."),
                                                                               "Transaction Type" = filter("Interest Paid"),
                                                                               "Posting Date" = field("Date filter"))); */
            FieldClass = FlowField;
        }
        field(53186; "Penalty Paid"; Decimal)
        {
            /*             CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                               "Transaction Type" = filter("Loan Penalty Paid"),
                                                                               "Loan No" = field("Loan  No."),
                                                                               "Posting Date" = field("Date filter"))); */
            FieldClass = FlowField;
        }
        field(53187; "Application Fee Paid"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter(Dividend),
                                                                              "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(53188; "Appraisal Fee Paid"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter("FOSA Account"),
                                                                              "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(53189; "Global Dimension 1 Code"; Code[25])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(53190; "Repayment Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Repayment Start Date");
            end;
        }
        field(53191; "Installment Including Grace"; Integer)
        {

            trigger OnValidate()
            begin
                if "Installment Including Grace" > "Max. Installments" then
                    Error('Installments cannot be greater than the maximum installments.');

                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53192; "Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53193; "Schedule Interest"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(53194; "Interest Debit"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Deposit Contribution"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53195; "Schedule Interest to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53196; "Repayments BF"; Decimal)
        {
        }
        field(68000; "Account No"; Code[20])
        {

        }
        field(68001; "BOSA No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(68002; "Staff No"; Code[20])
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68003; "BOSA Loan Amount"; Decimal)
        {
        }
        field(68004; "Loan Offset Amount"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Total Top Up" where("Loan No." = field("Loan  No."),
                                                                          "Client Code" = field("Client Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68005; "Loan Received"; Boolean)
        {
        }
        field(68006; "Period Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68007; "Current Repayment"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter("Interest Paid"),
                                                                              "Posting Date" = field("Period Date Filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(515102001; "Outstanding Interest"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                              "Posting Date" = field("Date filter"),
                                                                              "Customer No." = field("Client Code"),
                                                                              "Loan No" = field("Loan  No."))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(68009; "Oustanding Interest to Date"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter("Insurance Contribution" | "Deposit Contribution"),
                                                                              "Document No." = field("Document No. Filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(68010; "Current Interest Paid"; Decimal)
        {
            /*  CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = const("Insurance Contribution"),
                                                                   "Posting Date" = field("Period Date Filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(68011; "Document No. Filter"; Code[80])
        {
            FieldClass = FlowFilter;
        }
        field(68012; "Cheque No."; Code[10])
        {

            trigger OnValidate()
            begin
                /*
               Loan.SETRANGE(Loan."Cheque Number","Cheque Number");
               Loan.SETRANGE(Loan."Bela Branch","Bela Branch");
               IF Loan.FIND('-') THEN BEGIN
               IF Loan."Cheque Number"="Cheque Number" THEN
               ERROR('The Cheque No. has already been used');
               END; */

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then begin
                        if Loan."Cheque No." = "Cheque No." then
                            Error('Cheque No. already exists');
                    end;
                end;

            end;
        }
        field(68013; "Personal Loan Off-set"; Decimal)
        {
        }
        field(68014; "Old Account No."; Code[20])
        {
        }
        field(68015; "Loan Principle Repayment"; Decimal)
        {
        }
        field(68016; "Loan Interest Repayment"; Decimal)
        {
        }
        field(68017; "Contra Account"; Code[20])
        {
        }
        field(68018; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }

        field(68020; "Net Income"; Decimal)
        {
        }
        field(68021; "No. Of Guarantors"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Loan No" = field("Loan  No."),
                                                                 Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(68022; "Total Loan Guaranted"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details".Shares where("Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(68023; "Shares Boosted"; Boolean)
        {
        }
        field(68024; "Basic Pay"; Decimal)
        {

        }
        field(68025; "House Allowance"; Decimal)
        {


        }
        field(68026; "Other Allowance"; Decimal)
        {

        }
        field(68027; "Total Deductions"; Decimal)
        {


        }
        field(68028; "Cleared Effects"; Decimal)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68029; Remarks; Text[60])
        {
        }
        field(68030; Advice; Boolean)
        {
        }
        field(68031; "Special Loan Amount"; Decimal)
        {
            CalcFormula = sum("Loan Special Clearance"."Total Off Set" where("Loan No." = field("Loan  No."),
                                                                              "Client Code" = field("BOSA No")));
            Caption = 'Bridging Loan Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "Bridging Loan Posted"; Boolean)
        {
        }
        field(68033; "BOSA Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68034; "Previous Repayment"; Decimal)
        {
        }
        field(68035; "No Loan in MB"; Boolean)
        {
        }
        field(68036; "Recovered Balance"; Decimal)
        {
        }
        field(68037; "Recon Issue"; Boolean)
        {
        }
        field(68038; "Loan Purpose"; Code[20])
        {
            TableRelation = "Loans Purpose".Code;

            trigger OnValidate()
            begin
                if ObjLoanPurpose.Get("Loan Purpose") then
                    "Loan Purpose Description" := ObjLoanPurpose.Description;
            end;
        }
        field(68039; Reconciled; Boolean)
        {
        }
        field(68040; "Appeal Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if Posted = false then
                    Error('Appeal only applicable for issued loans.');
                "Approved Amount" := "Appeal Amount" + "Approved Amount";
                Validate("Approved Amount");
            end;
        }
        field(68041; "Appeal Posted"; Boolean)
        {
        }
        field(68042; "Project Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields("Loan Offset Amount", "Special Loan Amount");

                SpecialComm := 0;
                if "Special Loan Amount" > 0 then
                    SpecialComm := ("Special Loan Amount" * 0.01) + ("Special Loan Amount" + ("Special Loan Amount" * 0.01)) * 0.1;

                if "Project Amount" > ("Approved Amount" - ("Loan Offset Amount" + "Special Loan Amount" + SpecialComm)) then
                    Error('Amount to project cannot be more than the net payable amount i.e.  %1',
                         ("Approved Amount" - ("Loan Offset Amount" + "Special Loan Amount" + SpecialComm)));
            end;
        }
        field(68043; "Project Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"),
                                                "Account Type" = filter('SAVINGS' | 'ENCASHCH'),
                                                Status = const(Active));
        }
        field(68044; "Location Filter"; Integer)
        {

        }
        field(68045; "Other Commitments Clearance"; Decimal)
        {

        }
        field(68046; "Discounted Amount"; Decimal)
        {
            Editable = false;
        }
        field(68047; "Transport Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Mileage Allowance" := 0;
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68048; "Mileage Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Transport Allowance" := 0;
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68049; "System Created"; Boolean)
        {
        }
        field(68050; "Boosting Commision"; Decimal)
        {
        }
        field(68051; "Voluntary Deductions"; Decimal)
        {
        }
        field(68052; "4 % Bridging"; Boolean)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68053; "No. Of Guarantors-FOSA"; Integer)
        {
            FieldClass = Normal;
        }
        field(68054; Defaulted; Boolean)
        {
        }
        field(68055; "Bridging Posting Date"; Date)
        {
        }
        field(68056; "Commitements Offset"; Decimal)
        {
        }
        field(68057; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(68058; "Captured By"; Code[50])
        {
            TableRelation = User."User Security ID";
        }
        field(68059; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            ValidateTableRelation = false;
        }
        field(68060; "Recovered From Guarantor"; Boolean)
        {
        }
        field(68061; "Guarantor Amount"; Decimal)
        {
        }
        field(68062; "External EFT"; Boolean)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68063; "Defaulter Overide Reasons"; Text[90])
        {
        }
        field(68064; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68065; "Last Interest Pay Date"; Date)
        {
            /*             CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                                      "Transaction Type" = filter("Insurance Contribution"),
                                                                                      "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(68066; "Other Benefits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68067; "Recovered Loan"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68068; "1st Notice"; Date)
        {
        }
        field(68069; "2nd Notice"; Date)
        {
        }
        field(68070; "Final Notice"; Date)
        {
        }
        field(68071; "Outstanding Balance to Date"; Decimal)
        {
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter("Shares Capital" | "Interest Paid" | "FOSA Shares"),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter")));

            //  CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"), "Transaction Type" = filter(loan | repayment)));

            Editable = false;
            FieldClass = FlowField;
        }
        field(68072; "Last Advice Date"; Date)
        {
        }
        field(68073; "Advice Type"; Option)
        {
            OptionMembers = " ","Fresh Loan",Adjustment,Reintroduction,Stoppage;
        }
        field(68074; "Current Location"; Code[20])
        {

        }
        field(68090; "Compound Balance"; Decimal)
        {
        }
        field(68091; "Repayment Rate"; Decimal)
        {
        }
        field(68092; "Exp Repay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(68093; "ID NO"; Code[30])
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68094; RAmount; Decimal)
        {
        }
        field(68095; "Employer Code"; Code[20])
        {
        }
        field(68096; "Last Loan Issue Date"; Date)
        {
            /*             CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                                      "Transaction Type" = filter("Shares Capital"),
                                                                                      "Posting Date" = field("Date filter"))); */
            FieldClass = FlowField;
        }
        field(68097; "Lst LN1"; Boolean)
        {
        }
        field(68098; "Lst LN2"; Boolean)
        {
        }
        field(68099; "Last loan"; Code[20])
        {
            FieldClass = Normal;
        }
        field(69000; "Loans Category"; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69001; "Loans Category-SASRA"; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69002; "Bela Branch"; Code[10])
        {
        }
        field(69003; "Net Amount"; Decimal)
        {
        }
        field(69004; "Bank code"; Code[10])
        {

        }
        field(69005; "Bank Name"; Text[120])
        {
        }
        field(69006; "Bank Branch"; Code[30])
        {

        }
        field(69007; "Outstanding Loan"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Loan | repayment),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(69008; "Loan Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("Client Code"),
                                                             "Transaction Type" = filter(Plot),
                                                             "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69009; "Repay Count"; Integer)
        {
            /*             CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("Client Code"),
                                                                         "Transaction Type" = filter("Interest Paid"),
                                                                         "Loan No" = field("Loan  No."))); */
            FieldClass = FlowField;
        }
        field(69010; "Outstanding Loan2"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Amount = field("Approved Amount")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69011; "Offset Loan No"; Code[20])
        {
            CalcFormula = lookup("Loan Offset Details"."Loan No." where("Loan Top Up" = field("Loan  No."),
                                                                         "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(69012; Defaulter; Boolean)
        {
        }
        field(69013; DefaulterInfo; Text[30])
        {
        }
        field(69014; "Total Earnings(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69015; "Total Deductions(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69016; "Share Purchase"; Decimal)
        {
        }
        field(69017; "Product Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(69018; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(69019; "Amount Disburse"; Decimal)
        {
        }
        field(69020; Prepayments; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter"),
                                                                  "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69021; "Appln. between Currencies"; Option)
        {
            Caption = 'Appln. between Currencies';
            OptionCaption = 'None,EMU,All';
            OptionMembers = "None",EMU,All;
        }
        field(69022; "Expected Date of Completion"; Date)
        {
        }
        field(69023; "Total Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69024; "Recovery Mode"; Option)
        {
            OptionCaption = ' ,Checkoff,Standing Order,Salary,Pension,Recover From FOSA,Cash';
            OptionMembers = " ",Checkoff,"Standing Order",Salary,Pension,"Recover From FOSA",Cash;
        }
        field(69025; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;

            trigger OnValidate()
            begin
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    Evaluate("Instalment Period", '1D')
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        Evaluate("Instalment Period", '1W')
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            Evaluate("Instalment Period", '1M')
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                Evaluate("Instalment Period", '1Q');
            end;
        }
        field(69026; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69027; "Old Vendor No"; Code[20])
        {
        }
        field(69028; "Insurance 0.25"; Decimal)
        {
        }
        field(69029; "Total Offset Commission"; Decimal)
        {
        }
        field(69030; "Total loan Outstanding"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69031; "Monthly Shares Cont"; Decimal)
        {
        }
        field(69032; "Insurance On Shares"; Decimal)
        {
        }
        field(69033; "Total Loan Repayment"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Principle Repayment" where("Client Code" = field("Client Code"),
                                                                                 "Outstanding Balance" = filter(> 1)));
            FieldClass = FlowField;
        }
        field(69034; "Total Loan Interest"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Interest Repayment" where("Client Code" = field("Client Code"),
                                                                                "Outstanding Balance" = filter(> 1)));
            FieldClass = FlowField;
        }
        field(69035; "Net Payment to FOSA"; Decimal)
        {
        }
        field(69036; "Processed Payment"; Boolean)
        {
        }
        field(69037; "Date payment Processed"; Date)
        {
        }
        field(69038; "Attached Amount"; Decimal)
        {
        }
        field(69039; PenaltyAttached; Decimal)
        {
        }
        field(69040; InDueAttached; Decimal)
        {
        }
        field(69041; Attached; Boolean)
        {
        }
        field(69042; "Advice Date"; Date)
        {
        }
        field(69043; "Attachement Date"; Date)
        {
        }
        field(69044; "Total Loans Outstanding"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Loan | repayment),
                                                                              "Posting Date" = field("Date filter"))); */
            FieldClass = FlowField;
        }
        field(69045; "Jaza Deposits"; Decimal)
        {

            trigger OnValidate()
            begin

                //LoanType.GET("Loan Product Type");
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                if LoanApp.Find('-') then begin
                    Mdep := "Member Deposits" * 3;
                    // Message('Member Deposits *3 is %1', Mdep);

                    if "Jaza Deposits" > Mdep then
                        Error('Jaza deposits can not be more than 3 times the deposits');

                    //"Jaza Deposits":=ROUND(Mdep,1,'<' );
                    if "Jaza Deposits" > Mdep then
                        "Jaza Deposits" := Mdep
                    else
                        "Jaza Deposits" := "Jaza Deposits"

                end;
                Modify;


                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
                if PCharges.Find('-') then begin
                    "Levy On Jaza Deposits" := "Jaza Deposits" * (PCharges.Percentage / 100);
                    Modify;
                end;
            end;
        }
        field(69046; "Member Deposits"; Decimal)
        {
            Editable = false;
        }
        field(69047; "Levy On Jaza Deposits"; Decimal)
        {
        }
        field(69048; "Min Deposit As Per Tier"; Decimal)
        {
        }
        field(69049; "Total Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Principle Repayment" where("Client Code" = field("Client Code"),
                                                                                 "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69050; "Total Interest"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Interest Repayment" where("Client Code" = field("Client Code"),
                                                                                "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69051; Bridged; Boolean)
        {
        }
        field(69052; "Deposit Reinstatement"; Decimal)
        {
        }
        field(69053; "Member Found"; Boolean)
        {
        }
        field(69054; "Recommended Amount"; Decimal)
        {
        }
        field(69055; "Previous Years Dividend"; Decimal)
        {
        }
        field(69056; "partially Bridged"; Boolean)
        {
        }
        field(69057; "loan  Interest"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter("Insurance Contribution" | "Deposit Contribution"),
                                                                              "Posting Date" = field("Date filter"))); */
            Editable = false;
            FieldClass = FlowField;
        }
        field(69058; "BOSA Deposits"; Decimal)
        {
        }
        field(69059; "Offset Commission"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details".Commision where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69060; "Offset iNTEREST"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Interest Top Up" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69061; "No of Gurantors FOSA"; Integer)
        {

        }
        field(69062; "Loan No Found"; Boolean)
        {
        }
        field(69063; "Checked By"; Code[20])
        {
        }
        field(69064; "Approved By"; Code[20])
        {
        }
        field(69065; "New Repayment Period"; Integer)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(69066; "Rejected By"; Code[15])
        {
        }
        field(69067; "Loans Insurance"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter("Loan Insurance Charged" | "Loan Insurance Paid"),
                                                                              "Loan No" = field("Loan  No."))); */
            FieldClass = FlowField;
        }
        field(69068; "Last Int Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                          "Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(69069; "Approval remarks"; Code[15])
        {
        }
        field(69070; "Loan Disbursed Amount"; Decimal)
        {
        }
        field(69071; "Bank Bridge Amount"; Decimal)
        {
        }
        field(69072; "Approved Repayment"; Decimal)
        {
        }
        field(69073; "Rejection  Remark"; Text[30])
        {
        }
        field(69074; "Original Approved Amount"; Decimal)
        {
        }
        field(69075; "Original Approved Updated"; Boolean)
        {
        }
        field(69077; "Employer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
            FieldClass = FlowField;
        }
        field(69078; "Totals Loan Outstanding"; Decimal)
        {

            FieldClass = FlowField;
        }
        field(69079; "Interest Upfront Amount"; Decimal)
        {
        }
        field(69080; "Loan Processing Fee"; Decimal)
        {
        }
        field(69081; "Loan Appraisal Fee"; Decimal)
        {
        }
        field(69082; "Loan Insurance"; Decimal)
        {
        }
        field(69083; "Received Copy Of ID"; Boolean)
        {
        }
        field(69084; "Received Payslip/Bank Statemen"; Boolean)
        {
        }
        field(69085; "1st Time Loanee"; Boolean)
        {
        }
        field(69092; "Adjted Repayment"; Decimal)
        {
        }
        field(69093; "Member Category"; Option)
        {
            OptionCaption = 'Government Ministry,Other Institution,Private,Sacco Staff';
            OptionMembers = "Government Ministry","Other Institution",Private,"Sacco Staff";
        }
        field(69094; "Shares to Boost"; Decimal)
        {
        }
        field(69095; "Hisa Allocation"; Decimal)
        {
        }
        field(69096; "Hisa Commission"; Decimal)
        {
        }
        field(69097; "Hisa Boosting Commission"; Decimal)
        {
        }
        field(69098; "Share Capital Due"; Decimal)
        {
        }
        field(69099; IntersetInArreas; Decimal)
        {
        }
        field(69100; Upfronts; Decimal)
        {
        }
        field(69101; "Loan Calc. Offset Loan"; Boolean)
        {
        }
        field(69102; "Loan Transfer Fee"; Decimal)
        {
        }
        field(69103; "Loan SMS Fee"; Decimal)
        {
        }
        field(69104; "Scheduled Principal to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69105; Penalty; Decimal)
        {
        }
        field(69106; "Basic Pay H"; Decimal)
        {

        }
        field(69107; "Medical AllowanceH"; Decimal)
        {

        }
        field(69108; "House AllowanceH"; Decimal)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(69109; "Staff Assement"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Staff Assement" > 51510000 then
                    Error('Staff Assement is above maximum expected');
            end;
        }
        field(69110; Pension; Decimal)
        {

            trigger OnValidate()
            begin
                if Pension > 51510000 then
                    Error('Pension is above maximum expected');
            end;
        }
        field(69111; "Medical Insurance"; Decimal)
        {

        }
        field(69112; "Life Insurance"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Life Insurance" > 51510000 then
                    Error('Life Insurance is above maximum expected');
            end;
        }
        field(69113; "Other Liabilities"; Decimal)
        {

        }
        field(69114; "Transport/Bus Fare"; Decimal)
        {


        }
        field(69115; "Other Income"; Decimal)
        {


        }
        field(69116; "Pension Scheme"; Decimal)
        {


        }
        field(69117; "Other Non-Taxable"; Decimal)
        {
        }
        field(69118; "Monthly Contribution"; Decimal)
        {


        }
        field(69119; "Sacco Deductions"; Decimal)
        {
        }
        field(69120; "Other Tax Relief"; Decimal)
        {
        }
        field(69121; NHIF; Decimal)
        {


        }
        field(69122; NSSF; Decimal)
        {


        }
        field(69123; PAYE; Decimal)
        {


        }
        field(69124; "Risk MGT"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "Risk MGT"<>xRec."Risk MGT" THEN BEGIN
                Changed:=TRUE;
                //"Advice Shares":=TRUE;
                "Welfare Advice Date":=TODAY;
                END;
                */

            end;
        }
        field(69125; "Other Loans Repayments"; Decimal)
        {

        }
        field(69126; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("Client Code"),
                                                                               "Loan No." = field("Loan  No.")));
            Description = 'End Payslip Details';
            FieldClass = FlowField;
        }
        field(69127; Staff; Boolean)
        {
        }
        field(69128; Disabled; Boolean)
        {
        }
        field(69129; "Staff Union Contribution"; Decimal)
        {
        }
        field(69130; "Non Payroll Payments"; Decimal)
        {
        }
        field(69131; "Gross Pay"; Decimal)
        {
        }
        field(69132; "Total DeductionsH"; Decimal)
        {
        }
        field(69133; "Utilizable Amount"; Decimal)
        {
        }
        field(69134; "Net Utilizable Amount"; Decimal)
        {
        }
        field(69135; "Net take Home"; Decimal)
        {
        }
        field(69136; Signature; Boolean)
        {
        }
        field(69137; "Witnessed By"; Code[20])
        {
            Enabled = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Witnessed By");
                if HREmp.Find('-') then begin
                    "Witness Name" := HREmp.Name;    //"First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                end;
            end;
        }
        field(69138; "Witness Name"; Text[40])
        {
            Enabled = false;
        }
        field(69139; "Received Copies of Payslip"; Boolean)
        {
        }
        field(69140; "Interest In Arrears"; Decimal)
        {
        }
        field(69141; "Private Member"; Boolean)
        {
        }
        field(69142; "Loan Processing"; Decimal)
        {
        }
        field(69143; "Total Offset Amount"; Decimal)
        {
        }
        field(69144; "Loan  Cash Cleared"; Decimal)
        {
        }
        field(69145; "Loan Cash Clearance fee"; Decimal)
        {
        }
        field(69146; "Loan Due"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Loan),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter")));
                        FieldClass = FlowField; */
        }
        field(69147; "Partial Disbursed(Amount Due)"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter(Loan),
                                                                              "Currency Code" = field("Currency Filter"),
                                                                              "Posting Date" = field("Date filter")));
                        FieldClass = FlowField; */
        }
        field(69148; "Loan Last Pay date 2009Nav"; Date)
        {
        }
        field(69149; "Loans Referee 1"; Code[5])
        {
            Enabled = false;
        }
        field(69150; "Loans Referee 1 Name"; Code[5])
        {
            Enabled = false;
        }
        field(69151; "Loans Referee 2"; Code[5])
        {
            Enabled = false;
        }
        field(69152; "Loans Referee 2 Name"; Code[5])
        {
            Enabled = false;
        }
        field(69153; "Loans Referee 1 Relationship"; Code[5])
        {

        }
        field(69154; "Loans Referee 2 Relationship"; Code[5])
        {

        }
        field(69155; "Loans Referee 1 Mobile No."; Code[5])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                if StrLen("Loans Referee 1 Mobile No.") <> 10 then
                    Error('Loans Referee 1 Mobile No. Can not be more or less than 10 Characters');
            end;
        }
        field(69156; "Loans Referee 2 Mobile No."; Code[5])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                if StrLen("Loans Referee 2 Mobile No.") <> 10 then
                    Error('Loans Referee 2 Mobile No. Can not be more or less than 10 Characters');
            end;
        }
        field(69157; "Loans Referee 1 Address"; Code[5])
        {
            Enabled = false;
        }
        field(69158; "Loans Referee 2 Address"; Code[5])
        {
            Enabled = false;
        }
        field(69159; "Loans Referee 1 Physical Addre"; Code[5])
        {
            Enabled = false;
        }
        field(69160; "Loans Referee 2 Physical Addre"; Code[5])
        {
            Enabled = false;
        }
        field(69161; "Loan to Appeal"; Code[5])
        {
            Enabled = false;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"));

            trigger OnValidate()
            begin
                LoanAppeal.Reset;
                LoanAppeal.SetRange(LoanAppeal."Loan  No.", "Loan to Appeal");
                if LoanAppeal.Find('-') then begin
                    "Loan to Appeal Approved Amount" := LoanAppeal."Approved Amount";
                    "Loan to Appeal issued Date" := LoanAppeal."Issued Date";
                end;
            end;
        }
        field(69162; "Loan to Appeal Approved Amount"; Decimal)
        {
            Enabled = false;
        }
        field(69163; "Loan to Appeal issued Date"; Date)
        {
            Enabled = false;
        }
        field(69164; "Loan Appeal"; Boolean)
        {
        }
        field(69165; "Disbursed By"; Code[15])
        {
        }
        field(69166; "Member Account Category"; Option)
        {
            OptionCaption = 'Individual,Corporate,Joint,Group';
            OptionMembers = Individual,Corporate,Joint,Group;
        }
        field(69167; "Member Not Found"; Boolean)
        {
        }
        field(69168; "Loan to Reschedule"; Code[15])
        {
            TableRelation = "Loans Register"."Loan  No." where("BOSA No" = field("BOSA No"),
                                                                Posted = filter(true));

            trigger OnValidate()
            begin
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Reschedule");
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    "Requested Amount" := LoanApp."Outstanding Balance";
                    "Recommended Amount" := LoanApp."Outstanding Balance";
                    "Approved Amount" := LoanApp."Outstanding Balance";
                    "Loan Product Type" := LoanApp."Loan Product Type";
                    Interest := LoanApp.Interest;
                    "Application Date" := Today;

                end;


                if LoanType.Get("Loan Product Type") then begin
                    Installments := LoanType."Default Installements";
                    Validate("Loan Product Type");
                end;
            end;
        }
        field(69169; Rescheduled; Boolean)
        {
        }
        field(69170; "Loan Rescheduled Date"; Date)
        {
        }
        field(69171; "Loan Rescheduled By"; Code[20])
        {
        }
        field(69172; "Reason For Loan Reschedule"; Text[40])
        {
        }
        field(69173; "Loan Under Debt Collection"; Boolean)
        {
        }
        field(69174; "Loan Debt Collector"; Code[15])
        {
            TableRelation = Vendor."No." where("Debt Collector" = filter(true));

            trigger OnValidate()
            begin
                Vend.Reset;
                CalcFields("Outstanding Balance");
                Vend.SetRange(Vend."No.", "Loan Debt Collector");
                if Vend.Find('-') then begin
                    "Loan Debt Collector Interest %" := Vend."Debt Collector %";
                    "Loan Under Debt Collection" := true;
                    "Debt Collector Name" := Vend.Name;
                    "Debt Collection date Assigned" := Today;
                    "Loan Bal As At Debt Collection" := "Outstanding Balance";
                end;
            end;
        }
        field(69175; "Loan Debt Collector Interest %"; Decimal)
        {
        }
        field(69176; "Debt Collection date Assigned"; Date)
        {
        }
        field(69177; "Debt Collector Name"; Code[40])
        {
        }
        field(69178; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(69179; Discard; Boolean)
        {
        }
        field(69180; Upraised; Boolean)
        {
        }
        field(69181; "Pension No"; Code[10])
        {
            Enabled = false;
        }
        field(69182; "Loan Series Count"; Integer)
        {
        }
        field(69183; "Loan Account No"; Code[15])
        {
        }
        field(69184; Deductible; Boolean)
        {
        }
        field(69185; "Outstanding Balance-Capitalize"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Loan | repayment),
                                                                              "Posting Date" = field("Date filter"),
                                                                              "Loan No" = field("Loan  No.")));
                        FieldClass = FlowField; */
        }
        field(69186; "Last Interest Due Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                          "Posting Date" = field("Date filter"),
                                                                          "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69187; "Amount Payed Off"; Decimal)
        {

        }
        field(69188; "Amount in Arrears"; Decimal)
        {
        }
        field(69189; "No of Months in Arrears"; Integer)
        {
        }
        field(69190; "No of Active Loans"; Integer)
        {
        }
        field(69191; "Doublicate Loans"; Boolean)
        {
        }
        field(69192; "Capitalized Charges"; Decimal)
        {
        }
        field(69193; "Armotization Factor"; Decimal)
        {
        }
        field(69194; "Sacco Interest"; Decimal)
        {
        }
        field(69195; "Amortization Interest Rate"; Decimal)
        {
        }
        field(69196; "Total Outstanding Loan BAL"; Decimal)
        {
        }
        field(69197; "Member Group"; Code[15])
        {

        }
        field(69198; "Member Group Name"; Code[15])
        {
        }
        field(69199; "Payroll CodeB"; Option)
        {
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10,11,12,13';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10","11","12","13";
        }
        field(69200; "Group Shares"; Decimal)
        {
            Editable = false;
        }
        field(69201; "Cashier Branch"; Code[15])
        {
        }
        field(69202; Sceduled; Boolean)
        {
        }
        field(69203; "Boost this Loan"; Boolean)
        {

        }
        field(69204; "Boosted Amount"; Decimal)
        {
        }
        field(69205; "Notify Guarantor SMS"; Boolean)
        {
        }
        field(69206; "Boosted Amount Interest"; Decimal)
        {
        }
        field(69207; "Booster Loan No"; Code[10])
        {
        }
        field(69208; "Provident Fund"; Decimal)
        {
        }
        field(69209; "Provident Fund (Self)"; Decimal)
        {
        }
        field(69210; "Existing Loan Repayments"; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69211; "Chargeable Pay"; Decimal)
        {
        }
        field(69212; "Net take home 2"; Decimal)
        {
        }
        field(69213; "Least Retained Amount"; Decimal)
        {
        }
        field(69214; Reversed; Boolean)
        {
        }
        field(69215; "Principal Paid"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(repayment),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter")));
                        FieldClass = FlowField; */
        }
        field(69216; "Group Account"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Group Account" = "group account" then
                    "Loan Product Type" := 'BORESHA'
                else
                    "Loan Product Type" := 'INUKA';
            end;
        }
        field(69217; "Member Share Capital"; Decimal)
        {
        }
        field(69218; "Membership Duration(Years)"; Integer)
        {
        }
        field(69219; "Registration Date"; Date)
        {
        }
        field(69220; "Loan Deposit Multiplier"; Integer)
        {
        }
        field(69221; "Income Type"; Option)
        {
            OptionCaption = 'Payslip,Bank Statement,Payslip & Bank Statement,Business';
            OptionMembers = Payslip,"Bank Statement","Payslip & Bank Statement",Business;
        }
        field(69222; "Bank Statement Avarage Credits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69223; "Bank Statement Avarage Debits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69224; "Bank Statement Net Income"; Decimal)
        {
        }
        field(69225; "Loan Insurance Charged"; Decimal)
        {
            Editable = false;
        }
        field(69226; "Loan Insurance Paid"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter("Loan Insurance Paid"),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter")));
                        Editable = false;
                        FieldClass = FlowField; */
        }
        field(69227; "Outstanding Insurance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69228; "Salary Total Income"; Decimal)
        {

            trigger OnValidate()
            begin
                VarTotalMonthlyRepayments := 0;

                ObjLoansRec2.Reset;
                ObjLoansRec2.SetRange(ObjLoansRec2."Client Code", "Client Code");
                if ObjLoansRec2.FindSet then begin
                    ObjLoansRec2.CalcFields(ObjLoansRec2."Outstanding Balance");
                    repeat
                        if ObjLoansRec2."Outstanding Balance" > 0 then begin
                            ObjLoanOffsets.Reset;
                            ObjLoanOffsets.SetRange(ObjLoanOffsets."Loan No.", "Loan  No.");
                            ObjLoanOffsets.SetRange(ObjLoanOffsets."Loan Top Up", ObjLoansRec2."Loan  No.");
                            if ObjLoanOffsets.FindSet = false then begin
                                //VarTotalMonthlyRepayments := VarTotalMonthlyRepayments + ObjLoansRec2.Repayment;
                            end;
                        end;
                    until ObjLoansRec2.Next = 0;
                end;

                "Existing Loan Repayments" := VarTotalMonthlyRepayments;

                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69229; "SExpenses Rent"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69230; "SExpenses Transport"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69231; "SExpenses Education"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69232; "SExpenses Food"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69233; "SExpenses Utilities"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69234; "SExpenses Others"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := 0;
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others" + "SExpenses Education");
            end;
        }
        field(69235; "Salary Net Utilizable"; Decimal)
        {
        }
        field(69236; "Member House Group"; Code[15])
        {

        }
        field(69237; "Member House Group Name"; Code[20])
        {
        }
        field(69238; "Statement Account"; Code[15])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(69239; "Share Boosting Comission"; Decimal)
        {
        }
        field(69240; "BSExpenses Transport"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69241; "BSExpenses Education"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69242; "BSExpenses Food"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69243; "BSExpenses Utilities"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69244; "BSExpenses Others"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := 0;
                "Bank Statement Net Income" := ("Bank Statement Avarage Credits" - "Bank Statement Avarage Debits") - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69245; "BSExpenses Rent"; Decimal)
        {

        }
        field(69246; "Exisiting Loans Repayments"; Decimal)
        {
        }
        field(51516208; "Credit Officer"; Code[28])
        {

        }
        field(51516209; "Loan Centre"; Code[20])
        {
        }
        field(51516210; "Loan Reschedule Instalments"; Integer)
        {
        }
        field(51516211; "Disburesment Type"; Option)
        {
            OptionCaption = ' ,Full/Single disbursement,Tranche/Multiple Disbursement';
            OptionMembers = " ","Full/Single disbursement","Tranche/Multiple Disbursement";

            trigger OnValidate()
            begin

            end;
        }
        field(51516212; "Amount to Disburse on Tranch 1"; Decimal)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(51516213; "No of Tranch Disbursment"; Integer)
        {
        }
        field(51516214; "Loan Stages"; Code[10])
        {

        }
        field(51516215; "Loan Stage Description"; Text[30])
        {
        }
        field(51516216; "Loan Current Payoff Amount"; Decimal)
        {
        }
        field(51516217; "Outstanding Penalty"; Decimal)
        {
        }
        field(51516218; "Tranch Amount Disbursed"; Decimal)
        {
        }
        field(51516219; "Repayment Dates Rescheduled"; Boolean)
        {
        }
        field(51516220; "Repayment Dates Rescheduled On"; Date)
        {
        }
        field(51516221; "Repayment Dates Rescheduled By"; Code[20])
        {
        }
        field(51516222; Closed; Boolean)
        {
        }
        field(51516223; "Principle Paid to Date"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Plot),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter")));
                        FieldClass = FlowField; */
        }
        field(51516224; "Days In Arrears"; Integer)
        {
        }
        field(51516225; "New Repayment Start Date"; Date)
        {

            trigger OnValidate()
            begin
                if "New Repayment Start Date" > CalcDate('30D', "Reschedule Effective Date") then
                    Error('The New Repayment Start Date Cannot be More Than 30 Days From the Instalment Being Rescheduled');
            end;
        }
        field(51516226; "Loan Collateral Secured"; Boolean)
        {
            CalcFormula = exist("Loan Collateral Details" where("Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(51516227; "Loans Under CRB Notice"; Boolean)
        {
        }
        field(51516228; "Loan Purpose Description"; Text[50])
        {
        }
        field(51516229; "Credit Officer II"; Code[30])
        {

        }
        field(51516230; "Date of Rejection"; Date)
        {
        }
        field(51516231; "Intent to Reject"; Boolean)
        {
        }
        field(51516232; "Except From Penalty"; Boolean)
        {
        }
        field(51516233; "Loan Recovery Account FOSA"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(51516234; "Loan Amount Due"; Decimal)
        {
        }
        field(51516235; "Reschedule Effective Date"; Date)
        {
            TableRelation = "Loan Repayment Schedule"."Repayment Date" where("Loan No." = field("Loan  No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(51516236; "Working Date"; Date)
        {
        }
        field(51516237; "Excess LSA Recovery"; Boolean)
        {
        }
        field(51516238; "Excess Ufalme Recovery"; Boolean)
        {
        }
        field(51516239; "Current Principle Due"; Decimal)
        {
            Editable = false;
        }
        field(51516240; "Current Interest Due"; Decimal)
        {
        }
        field(51516241; "Current Insurance Due"; Decimal)
        {
        }
        field(51516242; "Current Penalty Due"; Decimal)
        {
        }
        field(51516243; "Actual Loan Balance"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Transaction Type" = filter(Loan | repayment | "Interest Due" | "Interest Paid" | "Loan Penalty Charged" | "Loan Penalty Paid" | "Loan Insurance Charged" | "Loan Insurance Paid"),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Posting Date" = field("Date filter")));
                        FieldClass = FlowField; */
        }
        field(51516244; "Closed On"; Date)
        {
        }
        field(51516245; "Closed By"; Code[20])
        {
        }
        field(51516246; "Principle Paid Historical"; Decimal)
        {

        }
        field(51516247; "Interest Paid Historical"; Decimal)
        {

        }
        field(51516248; "Insurance Paid Historical"; Decimal)
        {

        }
        field(51516249; "Penalty Paid Historical"; Decimal)
        {

        }
        field(51516250; "Application type"; Option)
        {
            OptionCaption = 'System,Mobile';
            OptionMembers = System,Mobile;
        }
        field(51516251; "Total Interest Paid"; Decimal)
        {
            Editable = false;
        }
        field(51516252; "Total Insurance Paid"; Decimal)
        {
            Editable = false;
        }
        field(51516253; "Total Penalty Paid"; Decimal)
        {
            Editable = false;
        }
        field(51516254; "Actual Loan Balance Historical"; Decimal)
        {

        }
        field(51516255; "Corporate Loan"; Boolean)
        {
        }
        field(51516256; "Loan Bal As At Debt Collection"; Decimal)
        {
        }
        field(51516257; "Offset Eligibility Amount"; Decimal)
        {
        }
        field(51516258; "Insider Status"; Option)
        {
            OptionCaption = ' ,Board Member,Staff Member';
            OptionMembers = " ","Board Member","Staff Member";
        }
        field(51516259; "Member Deposit Account No"; Code[20])
        {
        }
        field(51516260; "Freeze Interest Accrual"; Boolean)
        {
        }
        field(51516261; "Freeze Until"; Date)
        {
        }
        field(51516262; "Insurance Payoff"; Decimal)
        {
        }
        field(51516263; "OneOff Loan Repayment"; Boolean)
        {
        }
        field(51516264; "Repayment Due Date"; Date)
        {
        }
        field(51516265; "Borrowing Within Deposits"; Boolean)
        {
        }
        field(51516266; "Loan Installments to Skip"; Integer)
        {
        }
        field(51516267; "Skip Installments Effected"; Boolean)
        {
        }
        field(51516268; "Skip Installments Effected By"; Code[15])
        {
        }
        field(51516269; "Skip Installments Effected On"; DateTime)
        {
        }
        field(51516270; "Installment Date to Skip From"; Date)
        {
            TableRelation = "Loan Repayment Schedule"."Repayment Date" where("Loan No." = field("Loan  No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(51516271; "Exempt From Payroll Deduction"; Boolean)
        {
        }
        field(51516272; "Loan Missing in Portfolio Prov"; Boolean)
        {
        }
        field(51516273; "Last Repayment Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Transaction Type" = filter("Plot Repayment"),
                                                                          "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(51516274; "Loan Auctioneer"; Code[10])
        {
            TableRelation = Vendor where(Auctioneer = filter(true));

            trigger OnValidate()
            begin
                Vend.Reset;
                CalcFields("Outstanding Balance");
                Vend.SetRange(Vend."No.", "Loan Auctioneer");
                if Vend.Find('-') then begin
                    //"Loan Debt Collector Interest %":=Vend."Debt Collector %";
                    "Loan Under Auctioneer" := true;
                    "Date Auctioneer Assigned" := Today;
                    "Loan Auctioneer Name" := Vend.Name;
                end;
            end;
        }
        field(51516275; "Loan Auctioneer Name"; Code[15])
        {
        }
        field(51516276; "Date Auctioneer Assigned"; Date)
        {
        }
        field(51516277; "Loan Under Auctioneer"; Boolean)
        {
        }
        field(51516278; "Total Principle Paid"; Decimal)
        {
            /*             CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Client Code"),
                                                                              "Loan No" = field("Loan  No."),
                                                                              "Transaction Type" = filter(repayment)));
                        FieldClass = FlowField; */
        }
        field(51516279; "Member Credit Score"; Decimal)
        {
        }
        field(51516280; "1 3rd of Basic"; Decimal)
        {
        }
        field(51516281; "Bank Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(51516282; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51516283; "Insider-Board"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516284; "Insider-Employee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516285; "Loan Principal Offset"; Decimal)
        {
            /*             CalcFormula = sum("Loan Offset Details"."Principle Top Up" where("Loan No." = field("Loan  No."),
                                                                                          "Client Code" = field("Client Code")));
                        FieldClass = FlowField; */
        }
        field(51516286; "Interest Upfront"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516287; "Main Sector"; Code[20])
        {

        }
        field(51516288; "Sub Sector"; Code[20])
        {

        }
        field(51516289; "Sector Specific"; Code[20])
        {

        }
        field(51516290; "Sacco Decision"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516291; "Due Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5151000; PayPayee; Boolean) { DataClassification = ToBeClassified; }
        field(515102006; "Sector Description"; Text[1000])
        { DataClassification = ToBeClassified; }


    }

    keys
    {
        key(Key1; "Loan  No.")
        {
            Clustered = true;
        }
        key(Key2; Posted)
        {
        }
        key(Key3; "Loan Product Type")
        {
            SumIndexFields = "Requested Amount";
        }
        // key(Key4; Source, "Client Code", "Loan Product Type", "Issued Date")
        // {
        // }
        // key(Key5; "Batch No.", Source, "Loan Status", "Loan Product Type")
        // {
        //     SumIndexFields = "Approved Amount", "Appeal Amount";
        // }
        key(Key6; "BOSA Loan No.", "Account No", "Batch No.")
        {
        }
        key(Key7; "Old Account No.")
        {
        }
        key(Key8; "Client Code")
        {
        }
        key(Key9; "Staff No")
        {
        }
        key(Key10; "BOSA No")
        {
        }
        key(Key11; "Loan Product Type", "Client Code", Posted)
        {
        }
        key(Key12; "Client Code", "Loan Product Type", Posted, "Issued Date")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key13; "Loan Product Type", "Application Date", Posted)
        {
            SumIndexFields = "Approved Amount";
        }
        // key(Key14; Source, "Mode of Disbursement", "Issued Date", Posted)
        // {
        //    SumIndexFields = "Approved Amount";
        // }
        key(Key15; "Issued Date", "Loan Product Type")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key16; "Application Date")
        {
        }
        key(Key17; "Client Code", "Old Account No.")
        {
        }
        key(Key18; "Group Code")
        {
        }
        key(Key19; "Account No")
        {
        }
        // key(Key20; Source, "Issued Date", "Loan Product Type", "Client Code")
        // {
        // }
        key(Key21; "Client Code", "Loan Product Type")
        {
        }
        key(Key22; "Issued Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan  No.", "Client Code", "Client Name", "Loan Product Type", "Loan Product Type Name", "Outstanding Balance", "Outstanding Interest")
        {
        }
    }

    trigger OnDelete()
    begin
        //IF "Loan Status"="Loan Status"::Approved THEN
        Error('A loan cannot be deleted once created!.');
        //TESTFIELD(Posted,FALSE);
    end;



    trigger OnModify()
    begin
        /*
         //IF "Loan Status"="Loan Status"::Approved THEN
         //ERROR('A loan cannot be modified once it has been approved');
        IF "Batch No."<>'' THEN BEGIN
        IF LoansBatches.GET("Batch No.") THEN BEGIN
        IF LoansBatches.Status<>LoansBatches.Status::Open THEN
        ERROR('You cannot modify the loan because the batch is already %1',LoansBatches.Status);
        END;
        END;
        */
        //TESTFIELD(Posted,FALSE);

        /*IF ("Captured By" <> UPPERCASE(USERID)) AND ("Approval Status"="Approval Status"::Open) THEN
        ERROR('Cannot modify a loan being processed by %1',"Captured By");*/

    end;

    trigger OnRename()
    begin
        /*IF ("Captured By" <> UPPERCASE(USERID)) AND ("Approval Status"="Approval Status"::Open) THEN
        ERROR('Cannot modify a loan being processed by %1',"Captured By");
        */

    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanType: Record "Loan Products Setup";
        CustomerRecord: Record Customer;
        i: Integer;
        PeriodDueDate: Date;
        Gnljnline: Record "Gen. Journal Line";
        //   Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        IssuedDate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        NoOfGracePeriod: Integer;
        G: Integer;
        RunningDate: Date;
        NewSchedule: Record "Loan Repayment Schedule";
        ScheduleCode: Code[20];
        GP: Text[30];
        Groups: Record "Loan Product Cycles";
        PeriodInterval: Code[10];
        GLSetup: Record "General Ledger Setup";
        Users: Record User;
        FlatPeriodInterest: Decimal;
        FlatRateTotalInterest: Decimal;
        FlatPeriodInterval: Code[10];
        ProdCycles: Record "Loan Product Cycles";
        LoanApp: Record "Loans Register";
        MemberCycle: Integer;
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Vendor: Record Vendor;
        Cust: Record Customer;
        Vend: Record Vendor;
        Cust2: Record Customer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        UsersID: Record User;
        LoansBatches: Record "Loan Disburesment-Batching";
        //Employer: Record "Sacco Employers";
        GenSetUp: Record "Sacco General Set-Up";
        Batches: Record "Loan Disburesment-Batching";
        //  MovementTracker: Record "Movement Tracker";
        SpecialComm: Decimal;
        CustR: Record Customer;
        RAllocation: Record "Receipt Allocation";
        // "Standing Orders": Record "Standing Orders";
        //StatusPermissions: Record "Status Change Permision";
        CustLedg: Record "Cust. Ledger Entry";
        LoansClearedSpecial: Record "Loan Special Clearance";
        BridgedLoans: Record "Loan Special Clearance";
        Loan: Record "Loans Register";
        banks: Record "Bank Account";
        DefaultInfo: Text[180];
        sHARES: Decimal;
        MonthlyRepayT: Decimal;
        MonthlyRepay: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        RepaySched: Record "Loan Repayment Schedule";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Mwezikwisha: Date;
        AvailDep: Decimal;
        LoansOut: Decimal;
        Mdep: Decimal;
        //BANDING: Record "Deposit Tier Setup";
        Band: Decimal;
        TotalOutstanding: Decimal;
        Insuarence: Decimal;
        LoanTyped: Record "Loan Products Setup";
        DAY: Integer;
        loannums: Integer;
        Enddates: Date;
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        // DataSheet: Record "Data Sheet Main";
        Loans: Record "Loans Register";
        Chargeable: Decimal;
        Saccodeduct: Decimal;
        SaccoDedInt: Decimal;
        LoanAppeal: Record "Loans Register";
        HREmp: Record Customer;
        LoansRec: Record "Loans Register";
        TotalLoanOutstanding: Decimal;
        LineNoG: Integer;
        LoansG: Record "Loans Guarantee Details";
        ObjProductDepositLoan: Record "Product Deposit>Loan Analysis";
        ObjLoansRec: Record "Loans Register";
        // Dates: Codeunit "Dates Calculation";
        // ObjCellGroup: Record "Member House Groups";
        ObjGuarantors: Record "Loans Guarantee Details";
        ObjCust: Record Customer;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        // ObjDepositHistory: Record "Member Deposits Saving History";
        ObjAccountLedger: Record "Cust. Ledger Entry";
        //ObjStatementB: Record "Member Deposits Saving History";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjLoansRec2: Record "Loans Register";
        ObjLoanOffsets: Record "Loan Offset Details";
        VarTotalMonthlyRepayments: Decimal;
        ObjUser: Record User;
        //  ObjTranchDetails: Record "Tranch Disburesment Details";
        VarTranchNo: Integer;
        //  ObjLoanStages: Record "Loan Stages";
        ObjloanType: Record "Loan Products Setup";
        ObjLoanPurpose: Record "Loans Purpose";
        //ObjExcessRuleProducts: Record "Excess Repayment Rules Product";
        VarInterestRateMin: Decimal;
        VarInterestRateMax: Decimal;
        ObjAccount: Record Vendor;
        ObjLoans: Record "Loans Register";
        SFactory: Codeunit "SURESTEP Factory";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        VarLoanDisburesementDay: Integer;
    // BanksVer2: Record "Banks Ver2";


    procedure CreateAnnuityLoan()
    var
        LoanTypeRec: Record "Loan Products Setup";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
    end;


    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
    end;


    procedure GetGracePeriod()
    begin
        IssuedDate := "Loan Disbursement Date";
        GracePeiodEndDate := CalcDate("Grace Period", IssuedDate);
        InstalmentEnddate := CalcDate("Instalment Period", IssuedDate);
        GracePerodDays := GracePeiodEndDate - IssuedDate;
        InstalmentDays := InstalmentEnddate - IssuedDate;
        if InstalmentDays <> 0 then
            NoOfGracePeriod := ROUND(GracePerodDays / InstalmentDays, 1);
    end;


    procedure FlatRateCalc(var FlatLoanAmount: Decimal; var FlatInterestRate: Decimal) FlatRateCalc: Decimal
    begin
    end;

    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean
    begin
        /* := '';
        IF AccNo2 <> '' THEN
          CASE AccType2 OF
            AccType2::Customer:
              IF Cust2.GET(AccNo2) THEN
                "Currency Code" := Cust2."Currency Code";
            AccType2::Vendor:
              IF Vend2.GET(AccNo2) THEN
                "Currency Code" := Vend2."Currency Code";
            AccType2::"Bank Account":
              IF BankAcc2.GET(AccNo2) THEN
                "Currency Code" := BankAcc2."Currency Code";
          END;
        EXIT("Currency Code" <> '');
        */

    end;

    local procedure GetCurrency()
    begin
        /*IF "Additional-Currency Posting" =
           "Additional-Currency Posting"::"Additional-Currency Amount Only"
        THEN BEGIN
          IF GLSetup."Additional Reporting Currency" = '' THEN
            GLSetup.GET;
          CurrencyCode := GLSetup."Additional Reporting Currency";
        END ELSE
          CurrencyCode := "Currency Code";
        
        IF CurrencyCode = '' THEN BEGIN
          CLEAR(Currency);
          Currency.InitRoundingPrecision
        END ELSE
          IF CurrencyCode <> Currency.Code THEN BEGIN
            Currency.GET(CurrencyCode);
            Currency.TESTFIELD("Amount Rounding Precision");
          END;
         */

    end;

















    local procedure FnUpdateRepaymentAmount()
    begin
        //Repayments for amortised method
        InterestRate := Interest;
        if "Repayment Method" = "repayment method"::Amortised then begin
            // TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -Installments)) * "Requested Amount", 1, '>');
            // LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

            // LPrincipal := TotalMRepay - LInterest;
            // "Loan Principle Repayment" := LPrincipal;
            // "Loan Interest Repayment" := LInterest;


            if "Repayment Method" = "repayment method"::"Straight Line" then begin
                TestField(Installments);
                LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');

                ObjProductCharge.Reset;
                ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                if ObjProductCharge.FindSet then begin
                    LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                end;

                // Repayment := TotalMRepay + LInsurance;
            end;

            ObjProductCharge.Reset;
            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
            if ObjProductCharge.FindSet then begin
                LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
            end;

            //  Repayment := TotalMRepay + LInsurance;
        end;
        //End Repayments for amortised method

        LPrincipal := TotalMRepay - LInterest;
        "Loan Principle Repayment" := LPrincipal;
        "Loan Interest Repayment" := LInterest;
        RepayPeriod := 1;

        if "Repayment Method" = "repayment method"::"Straight Line" then begin
            TestField(Installments);
            LPrincipal := ROUND("Requested Amount" / RepayPeriod, 1, '>');
            LInterest := ROUND(((InterestRate / 1200) * "Requested Amount") * Installments, 1, '>');

            ObjProductCharge.Reset;
            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
            if ObjProductCharge.FindSet then begin
                LInsurance := ("Requested Amount" * (ObjProductCharge.Percentage / 100)) * Installments;
            end;

            //Repayment := LPrincipal + LInterest + LInsurance;
        end;
    end;


    procedure FnRungetexistingLoansRepaymentPerLoan(MemberNo: Code[50]; LoanNo: Code[20]) VarTotalLoanRepayments: Decimal
    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanTopup: Record "Loan Offset Details";
        Day: Integer;
        EndMonth: Date;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
    begin
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        ObjLoans.SetRange("Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            repeat
                SaccoGeneralSetUp.Get;
                SaccoGeneralSetUp.TestField("Last Date of Checkoff Advice");
                Day := Date2dmy(Today, 1);
                EndMonth := CalcDate('CM', Today);
                if Day > SaccoGeneralSetUp."Last Date of Checkoff Advice" then
                    EndMonth := CalcDate('1M+CM', EndMonth);
                LoanTopup.Reset;
                LoanTopup.SetRange("Loan Top Up", ObjLoans."Loan  No.");
                if not LoanTopup.FindFirst then begin
                    ObjRepaymentSchedule.Reset;
                    ObjRepaymentSchedule.SetRange(ObjRepaymentSchedule."Loan No.", ObjLoans."Loan  No.");
                    ObjRepaymentSchedule.SetRange("Repayment Date", 0D, EndMonth);
                    if ObjRepaymentSchedule.FindLast then begin
                        VarTotalLoanRepayments := VarTotalLoanRepayments + ObjRepaymentSchedule."Monthly Repayment";
                    end;
                end;
            until ObjLoans.Next = 0;

            exit(VarTotalLoanRepayments);
        end;
    end;


    procedure FnRungetexistingOffsetLoansRepayment(LoanNo: Code[20]) VarTotalLoanRepayments: Decimal
    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanTopup: Record "Loan Offset Details";
        Day: Integer;
        EndMonth: Date;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
    begin
        VarTotalLoanRepayments := 0;
        LoanTopup.Reset;
        LoanTopup.SetRange("Loan No.", LoanNo);
        if LoanTopup.FindSet then
            repeat
                VarTotalLoanRepayments += FnRungetexistingLoansRepaymentPerLoan(LoanTopup."Loan Top Up", LoanTopup."Client Code");
            until LoanTopup.Next = 0;
    end;







    //TotalDeductions:="Loans Register"."Monthly Contribution"+"Loans Register".NSSF+"Loans Register".NHIF+"Loans Register".PAYE+"Loans Register"."Exisiting Loans Repayments";
    //NetUtilizable:="Loans Register"."Utilizable Amount"+"Loans Register"."Bridge Amount Release"+"Loans Register"."Non Payroll Payments";


    //"Loans Register".MODIFY;
    //end;
}




