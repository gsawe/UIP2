Report 80000 "Payroll JournalTransfer."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "Current Month Filter", "No.";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin


                //For use when posting Pension and NSSF
                PostingGroup.Get('PAYROLL');
                PostingGroup.TestField("SSF Employer Account");
                PostingGroup.TestField("SSF Employee Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("Pension Employee Acc");
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then begin
                    strEmpName := '[' + "No." + '] ' + objEmp.Lastname + ' ' + objEmp.Firstname + ' ' + objEmp.Surname;
                end;

                LineNumber := LineNumber + 10;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then begin
                    repeat
                        ///Message('home %1', PeriodTrans."Transaction Code");
                        //NSSF
                        if PeriodTrans."Transaction Code" = 'NSSF' then begin

                            //Credit Payables


                            CreateJnlEntry(0, PostingGroup."SSF Employee Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            //Debit Staff Expense

                            CreateJnlEntry(0, PostingGroup."SSF Employer Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0, 1, '',
                            SaccoTransactionType, GlobalDim3, "No.");


                        end;
                        //nhif
                        //if PeriodTrans."Journal Account Code" <> '' then begin
                        if PeriodTrans."Journal Account Type" <> PeriodTrans."Journal Account Type"::" " then begin
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                AmountToDebit := PeriodTrans.Amount;

                            if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                AmountToCredit := PeriodTrans.Amount;

                            if PeriodTrans."Journal Account Type" = 1 then
                                IntegerPostAs := 0;
                            if PeriodTrans."Journal Account Type" = 2 then
                                IntegerPostAs := 1;

                            SaccoTransactionType := Saccotransactiontype::" ";
                            // Message('%1-%2-%3', PeriodTrans."Employee Code", PeriodTrans."coop parameters");
                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then
                                SaccoTransactionType := Saccotransactiontype::"Loan Repayment";

                            if (PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest") and
                            (PeriodTrans."Transaction Code" <> '0035-INT')
                            then
                                SaccoTransactionType := Saccotransactiontype::"Interest Paid";



                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares then
                                SaccoTransactionType := Saccotransactiontype::"Deposit Contribution";

                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Holiday then
                                SaccoTransactionType := Saccotransactiontype::"Holiday Savings";



                            if PeriodTrans."Journal Account Type" = PeriodTrans."journal account type"::Customer then begin
                                PeriodTrans."Journal Account Type" := PeriodTrans."journal account type"::Customer;
                            end;

                            CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit, AmountToCredit,
                            PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, GlobalDim3, "No.");


                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Pension then begin
                                //Get from Employer Deduction
                                EmployerDed.Reset;
                                EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                                EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                                if EmployerDed.Find('-') then begin
                                    //Credit Payables
                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0,
                                    EmployerDed.Amount, PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), EmployerDed.Amount, 0, 1, '',
                                    SaccoTransactionType, GlobalDim3, "No.");

                                end;
                                // end;


                            end;

                        end;
                    until PeriodTrans.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin

                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARY');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARY';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARY');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;

                //"Slip/Receipt No":=UPPERCASE(objPeriod."Period Name");
                "Slip/Receipt No" := kk."Period Name";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "Payroll Calender."."Date Opened";
                }
                field("Document No"; DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; varPostingDate)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        PeriodFilter := "Payroll Employee.".GetFilter("Current Month Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "Payroll Employee.".GetRangeMin("Current Month Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);

        if UserSetup.Get(UserId) then begin
           // if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        PeriodTrans: Record "prPeriod Transactions.";
        objEmp: Record "Payroll Employee.";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        ControlInfo: Record "Control-Information.";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record "Payroll Employee.";
        TaxableAmount: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "Payroll Transaction Code.";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings","Kanisa Savings","Standing Order Charges","Watoto Savings","Withdrawable Savings",Housing,"Holiday Savings";
        EmployerDed: Record "Payroll Employer Deductions.";
        GlobalDim3: Code[10];
        kk: Record "Payroll Calender.";
        UserSetup: Record "User Setup";
        DocumentNo: Code[10];
        varPostingDate: Date;


    procedure CreateJnlEntry(AccountType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings","Kanisa Savings","Standing Order Charges","Watoto Savings","Withdrawable Savings",Housing; BalAccountNo: Code[20]; MemberNo: Code[50])
    begin

        if AccountType = Accounttype::Customer then begin
            AccountType := Accounttype::Customer;

            GlobalDime1 := 'BOSA';
        end;
        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init;
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'SALARY';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := DocumentNo;
        GeneraljnlLine."Loan No" := LoanNo;
        GeneraljnlLine."Transaction Type" := TransType;
        GeneraljnlLine."Posting Date" := varPostingDate;
        if TransType <> Transtype::" " then begin
            GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::Customer;
            GeneraljnlLine."Account No." := AccountNo;
        end else begin
            GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::"G/L Account";
            GeneraljnlLine."Account No." := AccountNo;
        end;
        //GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = Postas::Debit then begin
            GeneraljnlLine."Debit Amount" := ROUND(DebitAmount, 1, '=');
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := ROUND(CreditAmount, 1, '=');
            GeneraljnlLine.Validate("Credit Amount");
        end;
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert;
    end;
}

