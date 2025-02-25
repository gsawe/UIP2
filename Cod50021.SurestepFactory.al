//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50021 "Surestep Factory"
{

    trigger OnRun()
    var
        Loan: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        VarLoanDisburesementDay: Integer;
        modify: Boolean;
    begin
        //MESSAGE(FORMAT(FnRunGetMemberLoanAmountDueFreezing('001006142')));
        //FnRunAutoUnFreezeMemberLoanDueAmount;

        //FnUpdateLoanPortfolio(20193101D);
        //FnRunProcessAssetDepreciationCustom
        //FnRunGetDepositArrearsPenalty;

        //FnRunSendScheduledAccountStatements()
        //FnCreateGuarantorRecoveryReimbursment('001018487',20000,'001401006986','REFUND00234');

        //FnAccrueInterestOneOffLoans('00130400027934');
        //FnRunAfterCashDepositProcess('0011721004576');

        //FnCreateGuarantorRecoveryReimbursment('00140515100016');

        //FnRunGetMembershipDormancyStatus(WORKDATE);

        //FnRunMemberCreditScoring('002000001');
        /*
        GenSetUp.GET;
        Loan.RESET;
        Loan.SETRANGE(Posted,TRUE);
        Loan.SETFILTER("Application Date",'<>%1',0D);
        IF Loan.FINDSET THEN
          REPEAT
                modify:=FALSE;
                 IF Loan."Loan Disbursement Date"=0D THEN BEGIN
                   modify:=TRUE;
                   Loan."Loan Disbursement Date":=Loan."Application Date";
                   VarLoanDisburesementDay:=DATE2DMY(Loan."Loan Disbursement Date",1);
        
                   END;
        
                    IF Loan."Repayment Start Date"=0D THEN BEGIN
                        modify:=TRUE;
        
                      IF VarLoanDisburesementDay>GenSetUp."Last Date of Checkoff Advice" THEN
                        Loan."Repayment Start Date":=CALCDATE('CM',(CALCDATE('1M',Loan."Loan Disbursement Date")))
                      ELSE
                        Loan."Repayment Start Date":=CALCDATE('CM',Loan."Loan Disbursement Date");
        
                    END;
        
                   IF modify THEN BEGIN
                     Loan.MODIFY;
                     COMMIT;
                   END;
        
                FnGenerateLoanRepaymentSchedule(Loan."Loan  No.");
        
        
            UNTIL Loan.NEXT = 0;*/

        Loan.Get('LN10130');



        Message(Format(FnCalculateLoanInterest(Loan, Today)));

        //FnRunPasswordChangeonNextLogin();

    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record User;
        ObjVendor: Record Vendor;
        ObjProducts: Record "Account Types-Saving Products";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        //ObjMembershipWithdrawal: Record "Membership Exist";
        ObjSalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjNoSeriesManagement: Codeunit NoSeriesManagement;
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjNoSeries: Record "No. Series Line";
        VarRepaymentPeriod: Date;
        VarLoanNo: Code[20];
        VarLastMonth: Date;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduledLoanBal: Decimal;
        VarDateFilter: Text;
        VarLBal: Decimal;
        VarArrears: Decimal;
        VarDate: Integer;
        VarMonth: Integer;
        VarYear: Integer;
        VarLastMonthBeginDate: Date;
        VarScheduleDateFilter: Text;
        VarScheduleRepayDate: Date;
        GenJournalLine: Record "Gen. Journal Line";
        //SMTP: Codeunit "SMTP Mail";
        TextBody: Text;
        TextMessage: Text;
        //Email: Codeunit Email;
        EmailBody: Text;
        //EmailMassage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";

        iEntryNo: Integer;
        FAJournalLine: Record "Gen. Journal Line";
        ScheduledOn: DateTime;
        VarOutputFormat: Text;



    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", UserId);
        if UserSetup.Find('-') then begin
            // branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + ObjCompInfo.Name;
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnSendOTPSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text; UserID: Code[30]; OTP: Integer)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 10;
        end
        else begin
            iEntryNo := 10;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserID;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '. Vision Sacco';
        SMSMessage."Telephone No" := MobileNumber;
        //  SMSMessage.OTP_User := UserID;
        //SMSMessage."OTP Code" := OTP;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnSendSMSScheduled(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text; ScheduledOn: DateTime)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 10;
        end
        else begin
            iEntryNo := 10;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '. Vision Sacco';// +' '+ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        //SMSMessage.ScheduledOn := ScheduledOn;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."Application Source" := AppSource;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks."Bank Account Branch", FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                end
                else
                    FCharged := ObjProductCharges.Amount;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;







    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", varUserId);
        if UserSetup.Find('-') then begin
            //  branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnClearGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
        end;
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Enum "Gen. Journal Account Type"; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; LoanNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."Client Code");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Mobile Phone No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Cust: Record Customer;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                // LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                //LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                //LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Loan Product Type" = 'DEFAULTER') and (LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec."Loan Repayment");
                        if LBalance < LoansRec."Loan Repayment" then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec."Loan Repayment";
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;


    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record "PAYE Brackets Credit";
        Taxrelief: Decimal;
        OTrelief: Decimal;
    begin
        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                                //Message('HOME1 %1-%2', Chargeable,BAND1);

                            end;

                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;

                                end;
                                //Message('HOME2 %1-%2', Chargeable,BAND2);
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                                //Message('HOME3 %1-%2', Chargeable,BAND3);
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;

                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 2400);
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;


    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    begin
        PostingDate := WorkDate;
        /*ObjSalesSetup.GET;
        
        ObjNextNo:=ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos",PostingDate);
          ObjNoSeries.RESET;
          ObjNoSeries.SETRANGE(ObjNoSeries."Series Code",ObjSalesSetup."Closure  Nos");
          IF ObjNoSeries.FINDSET THEN BEGIN
            ObjNoSeries."Last No. Used":=INCSTR(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used":=TODAY;
            ObjNoSeries.MODIFY;
          END;
        
        
        ObjMembershipWithdrawal.INIT;
        ObjMembershipWithdrawal."No.":=ObjNextNo;
        ObjMembershipWithdrawal."Member No.":=MemberNo;
        //IF ObjMembers.GET(MemberNo) THEN BEGIN
         // ObjMembershipWithdrawal."Member Name":=ObjMembers.Name;
        //END;
        ObjMembershipWithdrawal."Withdrawal Application Date":=ApplicationDate;
        ObjMembershipWithdrawal."Closing Date":=ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal":=Reason;
        ObjMembershipWithdrawal.INSERT;
        
        ObjMembershipWithdrawal.VALIDATE(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.MODIFY;*/

        if ObjMembers.Get(MemberNo) then begin
            ObjMembers.Status := ObjMembers.Status::"Awaiting Exit";
            ObjMembers.Modify;
        end;

        Message('The Member has been marked as awaiting exit.');

    end;

    local procedure FnGetDepreciationValueofCollateral()
    begin
    end;


    procedure FnGetLoanAmountinArrears(VarLoanNo: Code[20]) VarArrears: Decimal
    begin
        VarRepaymentPeriod := WorkDate;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged");
            VarLoanNo := ObjLoans."Loan  No.";

            //================Get Last Day of the previous month===================================
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then begin
                if VarRepaymentPeriod = CalcDate('CM', VarRepaymentPeriod) then begin
                    VarLastMonth := VarRepaymentPeriod;
                end else begin
                    VarLastMonth := CalcDate('-1M', VarRepaymentPeriod);
                end;
                VarLastMonth := CalcDate('CM', VarLastMonth);
            end;
            VarDate := 1;
            VarMonth := Date2dmy(VarLastMonth, 2);
            VarYear := Date2dmy(VarLastMonth, 3);
            VarLastMonthBeginDate := Dmy2date(VarDate, VarMonth, VarYear);
            VarScheduleDateFilter := Format(VarLastMonthBeginDate) + '..' + Format(VarLastMonth);
            //End ===========Get Last Day of the previous month==========================================


            //================Get Scheduled Balance=======================================================
            ObjLSchedule.Reset;
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", VarScheduleDateFilter);
            if ObjLSchedule.FindFirst then begin
                VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                VarScheduleRepayDate := ObjLSchedule."Repayment Date";
            end;

            ObjLSchedule.Reset;
            ObjLSchedule.SetCurrentkey(ObjLSchedule."Repayment Date");
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            if ObjLSchedule.FindLast then begin
                if ObjLSchedule."Repayment Date" < Today then begin
                    VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                    VarScheduleRepayDate := ObjLSchedule."Repayment Date";
                end;
            end;
            //================End Get Scheduled Balance====================================================

            //================Get Loan Bal as per the date filter===========================================
            if VarScheduleRepayDate <> 0D then begin
                VarDateFilter := '..' + Format(VarScheduleRepayDate);
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLBal := ObjLoans."Outstanding Balance";
                //===============End Get Loan Bal as per the date filter=========================================

                VarLBal := ObjLoans."Outstanding Balance";

                //============Amount in Arrears================================================================
                VarArrears := VarScheduledLoanBal - VarLBal;
                if (VarArrears > 0) or (VarArrears = 0) then begin
                    VarArrears := 0
                end else
                    VarArrears := VarArrears;
            end;
        end;
        exit(VarArrears * -1);
    end;


    procedure FnCreateGnlJournalLineGuarantorRecovery(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; VarRecoveryType: Option Normal,"Guarantor Recoverd","Guarantor Paid"; VarLoanRecovered: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Recovery Transaction Type" := VarRecoveryType;
        GenJournalLine."Recoverd Loan" := VarLoanRecovered;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors2: Record "Loans Guarantee Details";
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetFilter(ObjLoanGuarantors."Outstanding Balance", '>%1', 0);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjLoanGuarantors."Amont Guaranteed" > 0 then begin
                        ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                        if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            if ObjLoans."Outstanding Balance" > 0 then begin
                                VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                                if ObjLoanGuarantors."Total Loans Guaranteed" <> 0 then begin
                                    VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                end
                            end
                        end;
                    end;
                    VarTotaMemberLiability := VarTotaMemberLiability + VarApportionedLiability;
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
        exit(VarTotaMemberLiability);

    end;

    procedure FnGetAccountMonthlyCredit(VarAccountNo: Code[20]; VarTransactionDate: Date; VarMemberNo: Code[30]) VarMonthCredits: Decimal
    var
        ObjVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarStartDate: Integer;
        VarMonthMonth: Integer;
        VarMonthYear: Integer;
        VarMonthStartDate: Date;
        VarDateFilter: Text;
        ObjAccount: Record Vendor;
    begin
        VarStartDate := 1;
        VarMonthMonth := Date2dmy(VarTransactionDate, 2);
        VarMonthYear := Date2dmy(VarTransactionDate, 3);
        VarMonthStartDate := Dmy2date(VarStartDate, VarMonthMonth, VarMonthYear);
        VarDateFilter := Format(VarMonthStartDate) + '..' + Format(VarTransactionDate);

        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        if ObjAccount.FindSet then begin
            repeat

                ObjVendorLedger.Reset;
                ObjVendorLedger.SetRange(ObjVendorLedger."Vendor No.", ObjAccount."No.");
                ObjVendorLedger.SetFilter(ObjVendorLedger."Posting Date", VarDateFilter);
                //ObjVendorLedger.SetRange(ObjVendorLedger.Reversed, false);
                ObjVendorLedger.SetFilter(ObjVendorLedger.Amount, '<%1', 0);
                if ObjVendorLedger.FindSet then begin
                    ObjVendorLedger.CalcSums(ObjVendorLedger.Amount);
                    VarMonthCredits := VarMonthCredits + (ObjVendorLedger.Amount * -1);
                end;
            until ObjAccount.Next = 0;
            exit(VarMonthCredits);
        end;
    end;


    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Group Code" := GroupCode;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text[250]; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;




    local procedure FnRecoverLoansFromFOSAAccounts()
    var
        ObjLoanScheduleII: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
    begin
        ObjLSchedule.Reset;
        ObjLSchedule.SetRange(ObjLSchedule."Loan No.", ObjLoanScheduleII."Loan No.");
        ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", '=%1', WorkDate);
        if ObjLSchedule.FindSet then begin
            if ObjLoans.Get(ObjLSchedule."Loan No.") then begin

                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjLoans."Client Code");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                if ObjAccounts.FindSet then begin

                end;
            end;
        end;
    end;






    procedure FnGetOutstandingInterest(VarLoanNo: Code[30]) VarOutstandingInterest: Decimal
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.CalcFields(ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical");
        if ObjLoans.FindSet then begin
            VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            //MESSAGE('Interest Due is %1,Loan No %2',ObjLoans."Interest Due",ObjLoans."Loan  No.");
            if VarOutstandingInterest < 0 then
                VarOutstandingInterest := 0;
            exit(VarOutstandingInterest);
        end;
    end;


    procedure FnGetMemberUnsecuredLoanAmount(VarMemberNo: Code[30]) VarTotalUnsecuredLoans: Decimal
    var
        ObjSecurities: Record "Loan Collateral Details";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
    begin
        VarTotalCollateralValue := 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Member Collateral Value===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                ObjSecurities.SetFilter(ObjSecurities."Guarantee Value", '<%1', ObjLoans."Outstanding Balance");
                if ObjSecurities.FindSet then begin
                    VarTotalCollateralValue := VarTotalCollateralValue + (ObjLoans."Outstanding Balance" - ObjSecurities."Guarantee Value");
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Member Collateral Value=======================================

        VarTotalLoansnotSecuredbyCollateral := 0;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Loans not Secured by Collateral===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                if ObjSecurities.Find('-') = false then begin
                    VarTotalLoansnotSecuredbyCollateral := VarTotalLoansnotSecuredbyCollateral + ObjLoans."Outstanding Balance";
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Loans not Secured by Collateral=======================================

        VarTotalUnsecuredLoans := VarTotalCollateralValue + VarTotalLoansnotSecuredbyCollateral;
        exit(VarTotalUnsecuredLoans);
    end;




    procedure FnGetCoreCapital()
    var
        ShareCapitalAmount: Decimal;
        GLEntries: Record "G/L Entry";
        ShareCapitalAcc: Code[50];
        RetainedSurplusAcc: Code[50];
        RetainedSurplusAmount: Decimal;
        CapitalGrantAcc: Code[50];
        CapitalGrantAmount: Decimal;
        StatutoryReserveAcc: Code[50];
        StatutoryReserveAmount: Decimal;
        WithMembersSharesAcc: Code[50];
        WithMembersSharesAmount: Decimal;
        AdditionalSharesAcc: Code[50];
        AdditionalSharesAmount: Decimal;
    begin
    end;


    procedure FnConvertTexttoBeginingWordstostartWithCapital(CurValue: Text[250]) NewValue: Text[250]
    var
        Cap: Boolean;
        Indx: Integer;
    begin
        if (CurValue = '') then exit; //just to save a little extra needless processing in case of empty string

        Cap := true; //Capitalize the first letter of the sentence regardless
        CurValue := Lowercase(CurValue); //convert everything to lowercase "in case" we have rogue uppercase letters

        for Indx := 1 to StrLen(CurValue) do begin
            if (CurValue[Indx] = ' ') then begin
                NewValue += ' '; //by adding a hardcoded space here we avoid having to waste processing on a call to Format()
                Cap := true;
            end else begin
                if Cap then begin
                    NewValue += UpperCase(Format(CurValue[Indx]));
                    Cap := false;
                end else
                    NewValue += Format(CurValue[Indx])
            end;
        end;

        exit(NewValue);
    end;



    procedure FnRunSplitString(Text: Text[250]; Separator: Text[50]) TokenI: Text[100]
    var
        Pos: Integer;
        Token: Text[100];
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;

        TokenI := Token;
        exit(TokenI);
    end;






    procedure FnRunGetStatementDateFilter(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));


        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000) - 1;
    end;


    procedure FnRunGetStatementDateFilterAPP(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));


        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
        VarNewDate := CalcDate('-1D', VarNewDate);

    end;

    procedure FnRunGetNextTransactionDocumentNo() VarDocumentNo: Code[30]
    var
        ObjNoSeries: Record "General Ledger Setup";
    begin
        if ObjNoSeries.Get then begin
            //ObjNoSeries.TestField(ObjNoSeries."Transaction Document No");
            //VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Transaction Document No", 0D, true);
            exit(VarDocumentNo);
        end;
    end;










    procedure FnRunGetAccountAvailableBalance(VarAccountNo: Code[30]) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        if ObjVendors.Find('-') then begin

            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Cheque Discounted", ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions",
                                  ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions", ObjVendors."Cheque Discounted Amount");

            AvailableBal := ((ObjVendors.Balance + ObjVendors."Cheque Discounted") - ObjVendors."Uncleared Cheques" + ObjVendors."Over Draft Limit Amount" -
                          ObjVendors."Frozen Amount" - ObjVendors."ATM Transactions" - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;
        //Message('message function%1|%2', ObjVendors.Balance, ObjVendors."Balance (LCY)");
        exit(AvailableBal);
    end;






    procedure FnRunGetAccountBookBalance(VarAccountNo: Code[30]) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions", ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions",
            ObjVendors."Cheque Discounted Amount");
            AvailableBal := (ObjVendors.Balance + ObjVendors."Over Draft Limit Amount" - ObjVendors."ATM Transactions"
            - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

        end;
        exit(AvailableBal);
    end;


    procedure FnRunGetNextJvLineNo(JournalTemplate: Code[30]; JournalBatch: Code[30]) VarLineNo: Integer
    var
        General: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetCurrentkey(GenJournalLine."Line No.");
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        if GenJournalLine.FindLast then begin
            VarLineNo := GenJournalLine."Line No.";
        end;
        exit(VarLineNo + 100000);
    end;


    procedure FnRunOverdraftSweeping()
    var
        ObjAccounts: Record Vendor;
        ObjAccountsII: Record Vendor;
        VarODBalance: Decimal;
        VarAvailableOtherFOSAAccounts: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmountDeducted: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
        ObjAccountsII.Reset;
        ObjAccountsII.SetFilter(ObjAccountsII."Account Type", '%1', '406');
        ObjAccountsII.SetFilter(ObjAccountsII.Status, '%1|%2', ObjAccountsII.Status::Active, ObjAccountsII.Status::Dormant);
        ObjAccountsII.SetFilter(ObjAccountsII.Blocked, '%1', ObjAccountsII.Blocked::" ");
        ObjAccountsII.SetFilter(ObjAccountsII."Balance (LCY)", '<%1', 0);
        if ObjAccountsII.FindSet then begin
            repeat

                VarODBalance := ObjAccountsII."Balance (LCY)";


                VarAvailableOtherFOSAAccounts := 0;
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjAccountsII."BOSA Account No");
                ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                ObjAccounts.SetFilter(ObjAccounts.Blocked, '%1', ObjAccounts.Blocked::" ");
                ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2|%3|%4|%5', '401', '402', '403', '404', '501');
                if ObjAccounts.FindSet then begin
                    repeat
                        if (ObjAccountsII."Overdraft Sweeping Source" = ObjAccountsII."overdraft sweeping source"::"All FOSA Accounts")
                        or ((ObjAccountsII."Overdraft Sweeping Source" = ObjAccountsII."overdraft sweeping source"::"Specific FOSA Account") and
                            (ObjAccountsII."Specific OD Sweeping Account" = ObjAccounts."No.")) then begin
                            ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                            VarAvailableOtherFOSAAccounts := ((ObjAccounts.Balance + ObjAccounts."Over Draft Limit Amount") - ObjAccounts."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                            if ObjAccTypes.Find('-') then
                                VarAvailableOtherFOSAAccounts := VarAvailableOtherFOSAAccounts - ObjAccTypes."Minimum Balance";

                            ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
                            VarODBalance := ObjAccountsII."Balance (LCY)";
                            if (VarAvailableOtherFOSAAccounts > 0) and (VarODBalance < 0) then begin
                                if (VarODBalance * -1) > VarAvailableOtherFOSAAccounts then begin
                                    VarAmountDeducted := VarAvailableOtherFOSAAccounts
                                end else
                                    VarAmountDeducted := (VarODBalance * -1);

                                //FnRunRecoverODDebtCollectorFee(ObjAccountsII."No.", VarODBalance, VarAmountDeducted);

                                ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
                                VarODBalance := ObjAccountsII."Balance (LCY)";

                                if (VarODBalance * -1) > VarAvailableOtherFOSAAccounts then begin
                                    VarAmountDeducted := VarAvailableOtherFOSAAccounts
                                end else
                                    VarAmountDeducted := (VarODBalance * -1);



                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------

                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmountDeducted, 'FOSA', '',
                                'Overdraft Sweeping to - ' + ObjAccountsII."No.", '', GenJournalLine."application source"::CBS);

                                //------------------------------------2. Credit OD Account---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountsII."No.", WorkDate, VarAmountDeducted * -1, 'FOSA', '',
                                'Overdraft Sweeping From - ' + ObjAccounts."No.", '', GenJournalLine."application source"::CBS);
                                //--------------------------------(Credit OD Account)---------------------------------------------

                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                            end;
                        end;
                    until ObjAccounts.Next = 0;
                end;
            until ObjAccountsII.Next = 0;
        end;
    end;


    procedure FnRunTransferOverdrawAmounttoOD()
    var
        ObjAccounts: Record Vendor;
        ObjAccountsII: Record Vendor;
        VarODBalance: Decimal;
        VarAvailableOtherFOSAAccounts: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmountDeducted: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        ObjAccountsII.Reset;
        ObjAccountsII.SetFilter(ObjAccountsII."Account Type", '%1', '406');
        ObjAccountsII.SetFilter(ObjAccountsII.Status, '%1|%2', ObjAccountsII.Status::Active, ObjAccountsII.Status::Dormant);
        ObjAccountsII.SetFilter(ObjAccountsII.Blocked, '%1', ObjAccountsII.Blocked::" ");
        ObjAccountsII.SetFilter(ObjAccountsII."Over Draft Limit Expiry Date", '>=%1', WorkDate);
        if ObjAccountsII.FindSet then begin
            repeat
                VarODBalance := ObjAccountsII."Balance (LCY)";


                VarAvailableOtherFOSAAccounts := 0;
                ObjAccounts.CalcFields(ObjAccounts."Balance (LCY)");
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjAccountsII."BOSA Account No");
                ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                ObjAccounts.SetFilter(ObjAccounts.Blocked, '%1', ObjAccounts.Blocked::" ");
                ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2|%3|%4|%5', '401', '402', '403', '404', '501');
                if ObjAccounts.FindSet then begin
                    repeat

                        ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                        VarAvailableOtherFOSAAccounts := ((ObjAccounts.Balance + ObjAccounts."Over Draft Limit Amount") - ObjAccounts."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                        if ObjAccTypes.Find('-') then
                            VarAvailableOtherFOSAAccounts := VarAvailableOtherFOSAAccounts - ObjAccTypes."Minimum Balance";

                        if VarAvailableOtherFOSAAccounts < 0 then begin


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            //------------------------------------1. Debit OD Account---------------------------------------------------------------------------------------------

                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccountsII."No.", WorkDate, VarAvailableOtherFOSAAccounts * -1, 'FOSA', '',
                            'Overdraft Sweeping to - ' + ObjAccounts."No.", '', GenJournalLine."application source"::CBS);

                            //------------------------------------2. Credit FOSA Account---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAvailableOtherFOSAAccounts, 'FOSA', '',
                            'Overdraft Sweeping From - ' + ObjAccountsII."No.", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Credit OD Account)---------------------------------------------

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                        end;
                    until ObjAccounts.Next = 0;
                end;
            until ObjAccountsII.Next = 0;
        end;
    end;


    procedure FnCreateGnlJournalLineBranch(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                            TransactionDate: Date;
                                                                                                                                                                                                                                                                                                                                                            TransactionAmount: Decimal;
                                                                                                                                                                                                                                                                                                                                                            DimensionActivity: Code[40];
                                                                                                                                                                                                                                                                                                                                                            ExternalDocumentNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                            TransactionDescription: Text;
                                                                                                                                                                                                                                                                                                                                                            LoanNumber: Code[50];
                                                                                                                                                                                                                                                                                                                                                            AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
                                                                                                                                                                                                                                                                                                                                                            BranchCode: Code[30])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."Application Source" := AppSource;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := BranchCode;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnRunGetStatementFromDateApp(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
    end;


    procedure FnRunGetStatementToDateApp(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        if StrLen(DateFilter) = 8 then
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8)
        else
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 11, 18);

        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
    end;


    procedure FnRunGetStatementFromDate(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000);
    end;


    procedure FnRunGetStatementToDate(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin
        if StrLen(DateFilter) = 8 then
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8)
        else
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 11, 18);

        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000);
    end;




    procedure FnGenerateLoanRepaymentScheduleLoanCalculator(VarMemberNo: Code[30])
    var
        ObjLoanCalculator: Record "Loan Calculator";
        ObjRepaymentschedule: Record "Loan Repay Schedule-Calc";
        ObjLoansII: Record "Loans Register";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[40];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
        VarRepaymentStartDate: Date;
        LoanProductSetup: Record "Loan Products Setup";
    begin
        //======================================================================================Normal Repayment Schedule
        ObjLoanCalculator.Reset;
        ObjLoanCalculator.SetRange(ObjLoanCalculator."Member No", VarMemberNo);
        if ObjLoanCalculator.FindSet then begin
            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                    Evaluate(VarInPeriod, '1W')
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                        Evaluate(VarInPeriod, '1M')
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                            Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoanCalculator."Grace Period - Principle (M)";
            VarGrInterest := ObjLoanCalculator."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoanCalculator."Grace Period - Interest (M)";

            ObjLoanCalculator.TestField(ObjLoanCalculator."Repayment Start Date");

            //=================================================================Delete From Tables
            ObjRepaymentschedule.Reset;
            ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", VarMemberNo);
            ObjRepaymentschedule.DeleteAll;




            VarLoanAmount := ObjLoanCalculator."Requested Amount";
            VarInterestRate := ObjLoanCalculator."Interest rate";
            VarRepayPeriod := ObjLoanCalculator.Installments;
            VarInitialInstal := ObjLoanCalculator.Installments + ObjLoanCalculator."Grace Period - Principle (M)";
            VarLBalance := ObjLoanCalculator."Requested Amount";
            VarLNBalance := ObjLoanCalculator."Requested Amount";
            VarRunDate := ObjLoanCalculator."Repayment Start Date";
            VarRepaymentStartDate := ObjLoanCalculator."Repayment Start Date";

            VarInstalNo := 0;
            Evaluate(VarRepayInterval, '1W');

            //=================================================================================Repayment Frequency
            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                VarRunDate := CalcDate('-1D', VarRunDate)
            else
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                    VarRunDate := CalcDate('-1W', VarRunDate)
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                        VarRunDate := CalcDate('-1M', VarRunDate)
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                            VarRunDate := CalcDate('-1Q', VarRunDate);

            repeat
                VarInstalNo := VarInstalNo + 1;
                VarScheduleBal := VarLBalance;

                //=====================================================================================Repayment Frequency
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                    VarRunDate := CalcDate('1D', VarRunDate)
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                        VarRunDate := CalcDate('1W', VarRunDate)
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                            VarRunDate := CalcDate('1M', VarRunDate)
                        else
                            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                                VarRunDate := CalcDate('1Q', VarRunDate);


                //=======================================================================================Amortised
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::Amortised then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    ObjLoanCalculator.TestField(ObjLoanCalculator."Interest rate");
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                    VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                    VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                    VarLPrincipal := VarTotalMRepay - VarLInterest;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;

                //=======================================================================================Strainght Line
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::"Straight Line" then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');


                    ObjLoanCalculator.Repayment := VarLPrincipal + VarLInterest;
                    ObjLoanCalculator."Loan Principle Repayment" := VarLPrincipal;
                    ObjLoanCalculator."Loan Interest Repayment" := VarLInterest;
                    ObjLoanCalculator.Modify;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                        if ObjLoanCalculator."One Off Repayment" = true then
                            VarLInsurance := 0;
                    end;
                end;

                //=======================================================================================Reducing Balance
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::"Reducing Balance" then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator."Interest rate");
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;

                //=======================================================================================Constant
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::Constants then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Repayment);
                    if VarLBalance < ObjLoanCalculator.Repayment then
                        VarLPrincipal := VarLBalance
                    else
                        VarLPrincipal := ObjLoanCalculator.Repayment;
                    VarLInterest := ObjLoanCalculator."Interest rate";

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;


                //======================================================================================Grace Period
                if VarGrPrinciple > 0 then begin
                    VarLPrincipal := 0
                end else begin
                    if ObjLoanCalculator."Instalment Period" <> VarInPeriod then
                        VarLBalance := VarLBalance - VarLPrincipal;
                    VarScheduleBal := VarScheduleBal - VarLPrincipal;
                end;

                if VarGrInterest > 0 then
                    VarLInterest := 0;

                VarGrPrinciple := VarGrPrinciple - 1;
                VarGrInterest := VarGrInterest - 1;

                //======================================================================================Insert Repayment Schedule Table
                ObjRepaymentschedule.Init;
                ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                ObjRepaymentschedule."Loan No." := VarMemberNo;
                ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                ObjRepaymentschedule."Instalment No" := VarInstalNo;
                ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                ObjRepaymentschedule."Member No." := ObjLoanCalculator."Member No";
                ObjRepaymentschedule."Loan Category" := ObjLoanCalculator."Loan Product Type";
                ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
                ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                ObjRepaymentschedule."Loan Balance" := VarScheduleBal;
                ObjRepaymentschedule.Insert;
                VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);



            until VarLBalance < 1
        end;
    end;


    procedure FnRunGetAccountAvailableBalanceWithoutFreeze(VarAccountNo: Code[30]; VarBalanceDate: Date) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarDateFilter: Text;
    begin
        VarDateFilter := '..' + Format(VarBalanceDate);

        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        ObjVendors.SetFilter(ObjVendors."Date Filter", VarDateFilter);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Cheque Discounted", ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions",
                                    ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions", ObjVendors."Cheque Discounted Amount");
            AvailableBal := ((ObjVendors.Balance + ObjVendors."Cheque Discounted") - ObjVendors."Uncleared Cheques" + ObjVendors."Over Draft Limit Amount" -
                          ObjVendors."ATM Transactions" - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;

        exit(AvailableBal);
    end;



    local procedure FnRunRecoverDebtCollectorFee(VarLoanNo: Code[30]; RunningBalance: Decimal; VarFOSAAccount: Code[30]) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
    begin
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            // ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
            if ObjLoans.Find('-') then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;

                        if RunningBalance > ObjLoans."Outstanding Balance" then
                            VarDebtCollectorBaseAmount := ObjLoans."Outstanding Balance"
                        else
                            VarDebtCollectorBaseAmount := RunningBalance;

                        VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                        VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                        if RunningBalance > VarDebtCollectorFee then begin
                            AmountToDeduct := VarDebtCollectorFee
                        end else
                            AmountToDeduct := RunningBalance;

                        //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, VarFOSAAccount, WorkDate, AmountToDeduct, 'FOSA', '',
                        'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", '', GenJournalLine."application source"::CBS);

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", WorkDate, AmountToDeduct * -1, 'BOSA', VarLoanNo,
                        'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", VarLoanNo, GenJournalLine."application source"::CBS);
                        VarRunBal := RunningBalance - AmountToDeduct;
                        exit(VarRunBal);
                    end;
                end;
            end;
        end;
        exit(RunningBalance);
    end;

    local procedure fnCreateMBankingMemberAccount(RowID: Integer)
    begin
        /*
        ObjAccountToOpen.RESET;
        ObjAccountToOpen.SETRANGE("RowID",RowID);
        ObjAccountToOpen.SETRANGE("AccountMaintained",TRUE);
        IF ObjAccountToOpen.FIND('-'); THEN
          ERROR('This Account has been Maintained.');
        
        //-----End Check Mandatory Fields---------
        
        //----Check If account Already Exists------
        Acc.RESET;
        Acc.SETRANGE(Acc."BOSA Account No",ObjAccountToOpen."MemberNo");
        Acc.SETRANGE(Acc."Account Type",ObjAccountToOpen."ProductID");
        Acc.SETFILTER(Acc.Status,'<>%1',Acc.Status::Closed);
        Acc.SETFILTER(Acc.Status,'<>%1',Acc.Status::Deceased);
        Acc.SETRANGE(Acc.Status,Acc.Status::Active);
          IF Acc.FIND('-') THEN
            ERROR('Account already exists. %1',Acc."No.");
        //----End Check If account Already Exists------
        
        
        //---Checkfields If Fixed Deposit------------
        IF AccoutTypes.GET(ObjAccountToOpen."ProductID" ) THEN BEGIN
          IF AccoutTypes."Fixed Deposit" = TRUE THEN BEGIN
            TESTFIELD("Savings Account No.");
            //TESTFIELD("Maturity Type");
            //TESTFIELD("Fixed Deposit Type");
        END;
        //---End Checkfields If Fixed Deposit------------
        
        IF CONFIRM('Are you sure you want to create this account?',TRUE) = FALSE THEN
        EXIT;
        "Application Status" := "Application Status"::Converted;
        "Registration Date":=TODAY;
        MODIFY;
        
        //--Assign Account Nos Based On The Product Type-----
        //FOSA A/C FORMAT =PREFIX-MEMBERNO-PRODUCTCODE
        IF AccoutTypes.GET("Account Type") THEN
           AcctNo:=AccoutTypes."Account No Prefix"+'-'+ "BOSA Account No" +'-'+AccoutTypes."Product Code";
        
        //---Create Account on Vendor Table----
        Accounts.INIT;
        Accounts."No.":=AcctNo;
        Accounts."Date of Birth":="Date of Birth";
        Accounts.Name:=Name;
        Accounts."Creditor Type":=Accounts."Creditor Type"::"FOSA Account";
        Accounts."Personal No.":="Staff No";
        Accounts."ID No.":="ID No.";
        Accounts."Mobile Phone No":="Mobile Phone No";
        Accounts."Registration Date":="Registration Date";
        Accounts."Employer Code":="Employer Code";
        Accounts."BOSA Account No":="BOSA Account No";
        Accounts.Picture:=Picture;
        Accounts.Signature:=Signature;
        Accounts."Passport No.":="Passport No.";
        Accounts.Status:=Accounts.Status::Active;
        Accounts."Account Type":="Account Type";
        Accounts."Account Category":="Account Category";
        Accounts."Date of Birth":="Date of Birth";
        Accounts."Global Dimension 1 Code":='FOSA';
        Accounts."Global Dimension 2 Code":="Global Dimension 2 Code";
        Accounts.Address:=Address;
        Accounts."Address 2":="Address 2";
        Accounts.City:=City;
        Accounts."Phone No.":="Phone No.";
        Accounts."Telex No.":="Telex No.";
        Accounts."Post Code":="Post Code";
        Accounts.County:=County;
        Accounts."E-Mail":="E-Mail";
        Accounts."Home Page":="Home Page";
        Accounts."Registration Date":=TODAY;
        Accounts.Status:=Status::Approved;
        Accounts.Section:=Section;
        Accounts."Home Address":="Home Address";
        Accounts.District:=District;
        Accounts.Location:=Location;
        Accounts."Sub-Location":="Sub-Location";
        Accounts."Savings Account No.":="Savings Account No.";
        Accounts."Registration Date":=TODAY;
        Accounts."Vendor Posting Group":="Vendor Posting Group";
        Accounts.INSERT;
        "Application Status":="Application Status"::Converted;
        END;
        AccoutTypes."Last No Used":=INCSTR(AccoutTypes."Last No Used");
        AccoutTypes.MODIFY;
        
        Accounts.RESET;
        IF Accounts.GET(AcctNo) THEN BEGIN
          Accounts.VALIDATE(Accounts.Name);
          Accounts.VALIDATE(Accounts."Account Type");
          Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
          Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
          Accounts.MODIFY;
        
          //---Update BOSA with FOSA Account----
          IF ("Account Type" = 'SAVINGS') THEN BEGIN
            IF Cust.GET("BOSA Account No") THEN BEGIN
            Cust."FOSA Account No.":=AcctNo;
            Cust.MODIFY;
            END;
          END;
          //---End Update BOSA with FOSA Account----
          END;
        
        //----Insert Nominee Information------
        NextOfKinApp.RESET;
        NextOfKinApp.SETRANGE(NextOfKinApp."Account No","No.");
          IF NextOfKinApp.FIND('-') THEN BEGIN
            REPEAT
              NextOfKin.INIT;
              NextOfKin."Account No":="No.";
              NextOfKin.Name:=NextOfKinApp.Name;
              NextOfKin.Relationship:=NextOfKinApp.Relationship;
              NextOfKin.Beneficiary:=NextOfKinApp.Beneficiary;
              NextOfKin."Date of Birth":=NextOfKinApp."Date of Birth";
              NextOfKin.Address:=NextOfKinApp.Address;
              NextOfKin.Telephone:=NextOfKinApp.Telephone;
              //NextOfKin.Fax:=NextOfKinApp.Fax;
              NextOfKin.Email:=NextOfKinApp.Email;
              NextOfKin."ID No.":=NextOfKinApp."ID No.";
              NextOfKin."%Allocation":=NextOfKinApp."%Allocation";
              NextOfKin.INSERT;
             UNTIL NextOfKinApp.NEXT = 0;
          END;
        //----End Insert Nominee Information------
        
        //Insert Account Signatories------
        AccountSignApp.RESET;
        AccountSignApp.SETRANGE(AccountSignApp."Document No","No.");
          IF AccountSignApp.FIND('-') THEN BEGIN
            REPEAT
            AccountSign.INIT;
            AccountSign."Account No":=AcctNo;
            AccountSign.Names:=AccountSignApp."Account No";
            AccountSign."Date Of Birth":=AccountSignApp."Date Of Birth";
            AccountSign."ID No.":=AccountSignApp."ID No.";
            AccountSign.Signatory:=AccountSignApp.Signatory;
            AccountSign."Must Sign":=AccountSignApp."Must Sign";
            AccountSign."Must be Present":=AccountSignApp."Must be Present";
            AccountSign.Picture:=AccountSignApp.Picture;
            AccountSign.Signature:=AccountSignApp.Signature;
            AccountSign."Expiry Date":=AccountSignApp."Expiry Date";
            AccountSign.INSERT;
            "Application Status":="Application Status"::Converted;
            UNTIL AccountSignApp.NEXT = 0;
        END;
        //Insert Account Signatories------
        
        //--Send Confirmation Sms to The Member------
         SFactory.FnSendSMS('FOSA ACC','Your Account successfully created.Account No='+AcctNo,AcctNo,"Mobile Phone No");
         MESSAGE('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS',"Account Type",AcctNo);
        
         */

    end;


    procedure FnGetComputerName() ComputerName: Code[100]
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.Reset;
        ActiveSession.SetRange("User ID", UserId);
        if ActiveSession.Find('-') then
            ComputerName := ActiveSession."Client Computer Name";
        exit(ComputerName);
    end;

    procedure FnCreateGnlJournalLineBalancedII(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionDate: Date;
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionDescription: Text;
                                                                                                                                                                                                                                                                                                                                                                                                               BalancingAccountType: Enum "Gen. Journal Account Type";
                                                                                                                                                                                                                                                                                                                                                                                                               BalancingAccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionAmount: Decimal;
                                                                                                                                                                                                                                                                                                                                                                                                               DimensionActivity: Code[40];
                                                                                                                                                                                                                                                                                                                                                                                                               LoanNo: Code[20];
                                                                                                                                                                                                                                                                                                                                                                                                               External_Doc_No: Code[10])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;




    procedure FnRunPasswordChangeonNextLogin()
    var
        ObjUsers: Record User;
    begin
        /*ObjUsers.RESET;
        ObjUsers.SETFILTER(ObjUsers."Authentication Type",'<=%1',WORKDATE);
        ObjUsers.SETRANGE(ObjUsers."Change Password",FALSE);
        ObjUsers.SETFILTER(ObjUsers."User Name",'<>%1','SYSTEM');
        IF ObjUsers.FINDSET THEN
        BEGIN
          REPEAT
            ObjUsers."Change Password":=TRUE;
            ObjUsers.MODIFY;
          UNTIL ObjUsers.NEXT=0;
        END;
        */

    end;


    procedure FnRunPostPiggyBankCharges(VarPiggyBankAccount: Code[30]; VarExistingPiggyBank: Boolean)
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarPiggyBankFee: Decimal;
        VarTransactionNarrationDebit: Text;
        VarTransactionNarrationCredit: Text;
        VarTaxAmount: Decimal;
        VarAccountAvailableBal: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        EXTERNAL_DOC_NO: Code[20];
    begin
        ObjGenSetUp.Get;
        if ObjAccount.Get(VarPiggyBankAccount) then begin
            ObjAccountType.Reset;
            ObjAccountType.SetRange(ObjAccountType.Code, ObjAccount."Account Type");
            if ObjAccountType.FindSet then begin


                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'DEFAULT';
                DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
                EXTERNAL_DOC_NO := '';

                //==========================================================================Existing Piggy Bank
                if (VarExistingPiggyBank = true) or (ObjAccountType."Default Piggy Bank Issuance" = false) then begin
                    VarPiggyBankFee := ObjAccountType."Additional Piggy Bank Fee";
                    VarTransactionNarrationDebit := 'Additional Piggy Bank Purchase';
                    VarTransactionNarrationCredit := 'Piggy Bank Purchased by ' + ObjAccount."No." + ' ' + ObjAccount.Name;


                    VarTaxAmount := VarPiggyBankFee * (ObjGenSetUp."Excise Duty(%)" / 100);
                    VarAccountAvailableBal := FnRunGetAccountAvailableBalance(VarPiggyBankAccount);

                    if VarAccountAvailableBal < (VarPiggyBankFee + VarTaxAmount) then
                        Error('The Account does not have sufficient Balance to perform this Transaction. Available Bal is %1', VarAccountAvailableBal);

                    //=======================================================================================Debit FOSA Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                    ObjAccount."No.", WorkDate, VarPiggyBankFee, 'FOSA', DOCUMENT_NO, VarTransactionNarrationDebit, '', GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                   ObjAccount."No.", WorkDate, VarTaxAmount, 'FOSA', DOCUMENT_NO, 'Tax: Piggy Bank Fees', '', GenJournalLine."application source"::" ");


                    //=======================================================================================Credit Income Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    ObjAccountType."Piggy Bank Fee Account", WorkDate, VarPiggyBankFee * -1, 'FOSA', DOCUMENT_NO, VarTransactionNarrationCredit, '', GenJournalLine."application source"::" ");

                    //=======================================================================================Credit Tax:ATM Card Fee G/L Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    ObjGenSetUp."Excise Duty Account", WorkDate, VarTaxAmount * -1, 'FOSA', DOCUMENT_NO, 'Tax: Piggy Bank Fees - ' + ObjAccount."No.", '', GenJournalLine."application source"::" ");

                end else
                    if (ObjAccountType."Default Piggy Bank Issuance" = true) and (VarExistingPiggyBank = false) then begin
                        ObjGenSetUp.Get;
                        VarPiggyBankFee := ObjAccountType."New Piggy Bank Fee";

                        //=======================================================================================Debit Source G/L
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                        ObjGenSetUp."New Piggy Bank Debit G/L", WorkDate, VarPiggyBankFee, 'FOSA', DOCUMENT_NO, 'Piggy Bank Issue to ' + ObjAccount."No." + ' ' + ObjAccount.Name, '',
                         GenJournalLine."application source"::" ");


                        //=======================================================================================Credit Destination G/L
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                        ObjGenSetUp."New Piggy Bank Credit G/L", WorkDate, VarPiggyBankFee * -1, 'FOSA', DOCUMENT_NO, 'Piggy Bank Issue to ' + ObjAccount."No." + ' ' + ObjAccount.Name, '',
                        GenJournalLine."application source"::" ");
                    end;

                //CU Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;
        end;
    end;


    procedure FnCalculateLoanInterest(Loan: Record "Loans Register"; AsAt: Date) Int: Decimal
    var
        LBalance: Decimal;
    begin
        Int := 0;
        with Loan do begin
            SetFilter("Date filter", '..%1', AsAt);
            CalcFields("Outstanding Balance");
            LBalance := Loan."Outstanding Balance";
            if (Installments > 0) and (Interest > 0) then begin
                case Loan."Repayment Method" of
                    Loan."repayment method"::Amortised:
                        begin
                            Int := ROUND(LBalance / 100 / 12 * Loan.Interest);
                        end;
                    Loan."repayment method"::"Straight Line":
                        begin
                            Int := ROUND((Loan.Interest / 1200) * Loan."Approved Amount", 1, '>');
                        end;
                    Loan."repayment method"::"Reducing Balance":
                        begin
                            Int := ROUND((Loan.Interest / 12 / 100) * LBalance, 1, '>');
                        end;
                end;
            end;
        end;
    end;
}




