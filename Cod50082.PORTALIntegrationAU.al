/* Codeunit 50082 "PORTALIntegrationAU"
{

    trigger OnRun()
    begin
        //Message(fnRegister('8972572'));
        //MESSAGE( fnMemberStatement('000002','','');
        //fnTotalDepositsGraph('055000005','2013');
        //fnCurrentShareGraph('10000','2013');
        //fnTotalRepaidGraph('055000005','2013');
        //MESSAGE( MiniStatement('1024'));
        //fnMemberStatement('1024','006995Thox.pdf');
        //FnDepositsStatement('006995','dstatemnt.pdf');
        //FnLoanStatement('ACI015683','lsmnt.pdf');
        //MESSAGE(MiniStatement('006995'));
        //MESSAGE(FORMAT( FnLoanApplication('1023','D303',20000,'DEV',2,FALSE,FALSE,TRUE)));
        //fnFosaStatement('2483-05-1-1189','fosa1.pdf');
        //fnLoanRepaymentShedule('BLN0036','fstn11.pdf');
        //fndividentstatement('000547','divident.pdf')
        //fnLoanGuranteed('006995','loansguaranteed.pdf');
        //fnLoanRepaymentShedule('10000','victorLoanrepay.pdf');
        //fnLoanGurantorsReport('10000','Guarantors.pdf');
        //fnAtmApplications('0101-001-00266')
        //FnLoanStatement('1024','jk');
        //fnChangePassword('10000','1122','1200');
        //FnUpdateMonthlyContrib('2439', 2000);
        //fnUpdatePassword('10001','8340224','1340');
        //fnAtmApplications('2483-05-1-1189')
        //FnStandingOrders('2439','2483-05-1-1189','1W','1Y','2483-05-06-1189',20170913D,240,1);
        //MESSAGE(FORMAT( FnLoanApplication('2439','TANK LOAN',12500,'DEVELOPMENT',6,TRUE, FALSE, FALSE)));
        //fnFosaStatement('2747-006995-01', 'thox.pdf')
        //MESSAGE(FORMAT( Fnlogin('1024','')));
        //MESSAGE( MiniStatement('ACI015683'));
        //MESSAGE( fnAccountInfo('1024'));
        //MESSAGE(FORMAT(fnLoanDetails('d308')));
        //MESSAGE(FnmemberInfo('1024'));
        //MESSAGE(Fnloanssetup());
        //fnFeedback('1024', 'I have a big problem');
        //MESSAGE( FnloanCalc(100000, 10, 'D301'));
        //MESSAGE( FnNotifications());
        //MESSAGE(fnLoanDetails('ss'));
        //FnApproveGurarantors(
        //fnGuarantorsPortal('1024', '1023', 'BLN00148', 'Has requested you to quarantee laon');
        //FnApproveGurarantors(1, '000001',5, '',10000);
        //MESSAGE( FNAppraisalLoans('1024'));
        //MESSAGE( FnGetLoansForGuarantee('000001'));
        //MESSAGE(FnEditableLoans('1024','BLN00167'));
        //MESSAGE(fnLoans('1024'));
        //MESSAGE(FnmemberInfo('27394785'));
        //MESSAGE(FnGetLoansForGuarantee('000005'));
        //MESSAGE(FnApprovedGuarantors('1024', 'BLN00051'));
        //MESSAGE(FnloanCalc(40000,12,'D301'));
        //MESSAGE(FORMAT(fnTotalLoanAm('BLN00019')));
        //MESSAGE(fnLoans('000002'));
        //Fnquestionaire('000005', 'ASKDL', 'WATCH','TIME','FND','1',2,3,2,'Hellen');
        //FnNotifications('bln00084','manu1.pdf');
        //fnLoanApplicationform('10230');
        //fnLoanApplicationform('1050',TODAY, '10');
        //MESSAGE(FnLoanfo('1050'));
        //MESSAGE( FnLoanfo('5752'));
        //Message(Format(FnGetMonthlyDeduction('0006')));
    end;

    var
        objMember: Record Customer;
        Vendor: Record Vendor;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FILESPATH: label 'D:\Kentours Revised\KENTOURS\Kentours\Kentours\Downloads\';
        objLoanRegister: Record "Plots Register";
        // objAtmapplication: Record "ATM Card Applications";
        objRegMember: Record "Membership Applications";
        objNextKin: Record "Members Next of Kin";
        GenSetup: Record "General Ledger Setup";
        FreeShares: Decimal;
        glamount: Decimal;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        // objStandingOrders: Record "Standing Orders";
        CustomerLedgerEntries: Record 379;
        freq: DateFormula;
        dur: DateFormula;
        phoneNumber: Code[20];
        SMSMessages: Record "SMS Messages";
        OnlineOTP: Record "Online Portal OTP";
        iEntryNo: Integer;
        FAccNo: Text[250];
        sms: Text[250];
        objLoanApplication: Record "Plots Register";
        ClientName: Code[20];
        Loansetup: Record "Loan Products Setup";
        // feedback: Record Response;
        LoansPurpose: Record "Loans Purpose";
        ObjLoansregister: Record "Plots Register";
        LPrincipal: Decimal;
        LInterest: Decimal;
        Amount: Decimal;
        LBalance: Decimal;
        LoansRec: Record "Plots Register";
        // MemberSaving: Record MemberSavings;
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        FormNo: Code[40];
        Loanperiod: Integer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Customer;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record "Customer Price Group";
        //DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        loansregister: Record "Plots Register";
        OnlineUsers: Record "Online Portal Users";
        CapDiv: Decimal;
        DivCapTotal: Decimal;
        RunningPeriod: Code[10];
        LineNo: Integer;
        loansguarantee: Record "Loans Guarantee Details";
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        DivInTotal: Decimal;
        WTaxInTotal: Decimal;
        CapTotal: Decimal;
        Period: Code[20];
        WTaxShareCap: Decimal;
        ENtry: Integer;
        loanproducts: Record "Loan Products Setup";
        //Online: Record UnknownRecord170416;
        //setup: Record "Treasury Transactions";
        noseries: Codeunit NoSeriesManagement;
        memberApp: Record "Membership Applications";
        //JSONTextWriter: dotnet JsonTextWriter;
        //JSON: dotnet String;
        //StringWriter: dotnet StringWriter;
        //StringBuilder: dotnet StringBuilder;
        //FilePath: DotNet Path;
        PlotsRegister: Record "Plots Register";
        Projects: Record Projects;


    procedure MiniStatement(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
    begin

        BEGIN
            MiniStmt := '';
            objMember.RESET;
            objMember.SETRANGE("No.", MemberNo);
            IF objMember.FIND('-') THEN BEGIN
                minimunCount := 1;
                CustomerLedgerEntries.Reset();
                CustomerLedgerEntries.SETCURRENTKEY(CustomerLedgerEntries."Entry No.");
                CustomerLedgerEntries.ASCENDING(FALSE);
                CustomerLedgerEntries.SETRANGE(CustomerLedgerEntries."Customer No.", MemberNo);
                CustomerLedgerEntries.SETRANGE(CustomerLedgerEntries.Reversed, FALSE);
                IF CustomerLedgerEntries.FINDSET THEN BEGIN
                    MiniStmt := '';
                    REPEAT
                        amount := CustomerLedgerEntries."Credit Amount";
                        IF amount < 1 THEN amount := amount * -1;
                        MiniStmt := MiniStmt + FORMAT(CustomerLedgerEntries."Posting Date") + ':::' + COPYSTR(FORMAT(CustomerLedgerEntries."Transaction Type"), 1, 25) + ':::' +
                        FORMAT(amount) + '::::';
                        minimunCount := minimunCount + 1;
                        IF minimunCount > 5 THEN BEGIN
                            EXIT(MiniStmt);
                        END
                    UNTIL CustomerLedgerEntries.NEXT = 0;
                END;

            END;

        END;
        EXIT(MiniStmt);


    end;

    /*     procedure fnMemberStatement(MemberNo: Code[50]; StartDate: Date; EndDate: Date; var Base64Txt: Text)
        var
            Filename: Text[100];
            TempBlob: Codeunit "Temp Blob";
            StatementOutstream: OutStream;
            StatementInstream: InStream;
            MemberStatement: Report 80007;
            Base64Convert: Codeunit "Base64 Convert";
        begin

            Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
            objMember.Reset;
            objMember.SetRange(objMember."No.", MemberNo);
            objMember.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
            if objMember.Find('-') then begin
                MemberStatement.SetTableView(objMember);
                TempBlob.CreateOutStream(StatementOutstream);
                if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;

            end;
        end; */

    /* procedure fnMemberStatements(MemberNo: Code[50]; "filter": Text; var BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        /* Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;

        FileStream: dotnet FileStream; */
       // Outputstream: OutStream;
    /* begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);


        if objMember.Find('-') then begin
            // objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            //Report.SaveAsPdf(60886, Filename, objMember);

            FileMode := 4;
            FileAccess := 1;

            FileStream := _File.Open(Filename, FileMode, FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end; */

    /* procedure fndividentstatement(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        //DividendsStatement: Report 50012;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            // DividendsStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            //if DividendsStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
            //   TempBlob.CreateInStream(StatementInstream);
            Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
        end;

    end; */ 
    //end;


    /*     procedure fnLoanGuranteed(MemberNo: Code[50]; var Base64Txt: Text)
        var
            Filename: Text[100];
            TempBlob: Codeunit "Temp Blob";
            StatementOutstream: OutStream;
            StatementInstream: InStream;
            LoanGuaranteed: Report 80009;
            Base64Convert: Codeunit "Base64 Convert";
        begin

            Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
            objMember.Reset;
            objMember.SetRange(objMember."No.", MemberNo);
            if objMember.Find('-') then begin
                LoanGuaranteed.SetTableView(objMember);
                TempBlob.CreateOutStream(StatementOutstream);
                if LoanGuaranteed.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;

            end;
        end;
     */

    /*    procedure fnLoanRepaymentShedule("Loan No": Code[50]; path: Text[100])
       var
           "Member No": Code[100];
           filename: Text[250];
       begin
           filename := FILESPATH + path;
           if Exists(filename) then
               Erase(filename);
           objLoanRegister.Reset;
           objLoanRegister.SetRange(objLoanRegister.No, "Loan No");

           if objLoanRegister.Find('-') then begin
               Report.SaveAsPdf(60477, filename, objLoanRegister);
               Message(FILESPATH);
           end;
       end; */

    /*     procedure fnLoanGurantorsReport(MemberNo: Code[50]; var Base64Txt: Text)
        var
            Filename: Text[100];
            TempBlob: Codeunit "Temp Blob";
            StatementOutstream: OutStream;
            StatementInstream: InStream;
            //LoanGuarantors: Report 80010;
            Base64Convert: Codeunit "Base64 Convert";
        begin

            Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
            objMember.Reset;
            objMember.SetRange(objMember."No.", MemberNo);
            if objMember.Find('-') then begin
                LoanGuarantors.SetTableView(objMember);
                TempBlob.CreateOutStream(StatementOutstream);
                if LoanGuarantors.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;

            end;
        end; */


    /*     procedure fnAtmApplications(Account: Code[100])
        begin
            objAtmapplication.Init;
            objAtmapplication."Account No" := Account;
            objAtmapplication."Application Date" := Today;
            objAtmapplication."Request Type" := objAtmapplication."request type"::New;
            objAtmapplication."Card Status" := objAtmapplication."card status"::Pending;
            objAtmapplication.Validate(objAtmapplication."Account No");
            objAtmapplication.Insert;
        end;


        procedure fnAtmBlocking(Account: Code[100]; ReasonForBlock: Text[250])
        begin
            objAtmapplication.Reset;
            objAtmapplication.SetRange(objAtmapplication."Account No", Account);
            if objAtmapplication.Find('-') then begin
                objAtmapplication."Card Status" := objAtmapplication."card status"::Frozen;
                objAtmapplication."Reason for Account blocking" := ReasonForBlock;
                objAtmapplication.Modify;
            end;
        end;
     */

    /* procedure fnChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    var
        EncryptionManagement: Codeunit "Cryptography Management";
        InStream: InStream;
        PasswordText: Text;
        OutStream: OutStream;
        DecryptPassword: Text;
    begin
        updated := false;
        OnlineUsers.reset;
        OnlineUsers.SetRange("Member No.", memberNumber);
        OnlineUsers.SetRange(Password, currentPass);
        if OnlineUsers.FindFirst() then begin
            OnlineUsers.Password := newPass;
            OnlineUsers."Changed Password" := true;
            if OnlineUsers.Modify(true) then
                updated := true;
            exit(updated);
        end;
    end;
 */

    /* procedure fnTotalRepaidGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            //objMember.CALCFIELDS("Current Shares");
            total := objMember."Total Repayments";
            Message('current repaid is %1', total);
        end;
    end;

 */
   /*  procedure fnCurrentShareGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Current Shares");
            total := objMember."Current Shares";
            Message('current shares is %1', total);
        end;
    end;
 */

    /* procedure fnTotalDepositsGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        // objMember.RESET;
        // objMember.SETRANGE("No.", Mno);
        // IF objMember.FIND('-') THEN BEGIN
        //
        // objMember.SETFILTER("Date Filter",'0101'+year+'..1231'+year);
        // objMember.CALCFIELDS("Share Cap");
        // total:=objMember."Share Cap";
        // MESSAGE ('current deposits is %1', total);
        // END;
    end;


    procedure FnRegisterKin("Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; Address: Text; Idnomemberapp: Code[10])
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", Idnomemberapp);
            if objRegMember.Find('-') then begin
                objNextKin."Account No" := objRegMember."No.";
                objNextKin.Name := "Full Names";
                objNextKin.Relationship := Relationship;
                objNextKin."ID No." := "ID Number";
                objNextKin.Telephone := "Phone Contact";
                objNextKin.Address := Address;
                objNextKin.Insert(true);
            end;
        end;
    end;
 */

   /*  procedure FnMemberApply("First Name": Code[30]; "Mid Name": Code[30]; "Last Name": Code[30]; "PO Box": Text; Residence: Code[30]; "Postal Code": Text; Town: Code[30]; "Phone Number": Code[30]; Email: Text; "ID Number": Code[30]; "Branch Code": Code[30]; "Branch Name": Code[30]; "Account Number": Code[30]; Gender: Option; "Marital Status": Option; "Account Category": Option; "Application Category": Option; "Customer Group": Code[30]; "Employer Name": Code[30]; "Date of Birth": Date) num: Text
    begin
        begin

            objRegMember.Reset;
            objRegMember.SetRange("ID No.", "ID Number");
            if objRegMember.Find('-') then begin
                Message('already registered');
            end
            else begin
                objRegMember.Init;
                objRegMember.Name := "First Name" + ' ' + "Mid Name" + ' ' + "Last Name";
                objRegMember.Address := "PO Box";
                objRegMember."Address 2" := Residence;
                objRegMember."Postal Code" := "Postal Code";
                objRegMember.Town := Town;
                objRegMember."Mobile Phone No" := "Phone Number";
                objRegMember."E-Mail (Personal)" := Email;
                objRegMember."Date of Birth" := "Date of Birth";
                objRegMember."ID No." := "ID Number";
                objRegMember."Bank Code" := "Branch Code";
                objRegMember."Bank Name" := "Branch Name";
                objRegMember."Bank Account No" := "Account Number";
                objRegMember.Gender := Gender;
                objRegMember."Created By" := UserId;
                objRegMember."Global Dimension 1 Code" := 'BOSA';
                objRegMember."Date of Registration" := Today;
                objRegMember.Status := objRegMember.Status::Open;
                objRegMember."Application Category" := "Application Category";
                objRegMember."Account Category" := "Account Category";
                objRegMember."Marital Status" := "Marital Status";
                objRegMember."Employer Name" := "Employer Name";
                objRegMember."Customer Posting Group" := "Customer Group";
                objRegMember.Insert(true);
            end;


            //FnRegisterKin('','','','','');
        end;
    end; */

    /* local procedure FnFreeShares("Member No": Text) Shares: Text
    begin
        begin
            begin
                GenSetup.Get();
                FreeShares := 0;
                glamount := 0;

                objMember.Reset;
                objMember.SetRange(objMember."No.", "Member No");
                if objMember.Find('-') then begin
                    objMember.CalcFields("Current Shares");
                    LoansGuaranteeDetails.Reset;
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", objMember."No.");
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                    if LoansGuaranteeDetails.Find('-') then begin
                        repeat
                            glamount := glamount + LoansGuaranteeDetails."Amont Guaranteed";
                        //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                        until LoansGuaranteeDetails.Next = 0;
                    end;
                    //  FreeShares:=(objMember."Current Shares"*GenSetup."Contactual Shares (%)")-glamount;
                    Shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
                end;
            end;
        end;
    end;
 */

    /*     procedure FnStandingOrders(BosaAcNo: Code[30]; SourceAcc: Code[50]; frequency: Text; Duration: Text; DestAccNo: Code[30]; StartDate: Date; Amount: Decimal; DestAccType: Option)
        begin
            objStandingOrders.Init();
            objStandingOrders."BOSA Account No." := BosaAcNo;
            objStandingOrders."Source Account No." := SourceAcc;
            objStandingOrders.Validate(objStandingOrders."Source Account No.");
            if Format(freq) = '' then
                Evaluate(freq, frequency);
            objStandingOrders.Frequency := freq;
            if Format(dur) = '' then
                Evaluate(dur, Duration);
            objStandingOrders.Duration := dur;
            objStandingOrders."Destination Account No." := DestAccNo;
            objStandingOrders.Validate(objStandingOrders."Destination Account No.");
            objStandingOrders."Destination Account Type" := DestAccType;
            objStandingOrders.Amount := Amount;
            objStandingOrders."Effective/Start Date" := StartDate;
            objStandingOrders.Validate(objStandingOrders.Duration);
            objStandingOrders.Status := objStandingOrders.Status::Open;
            objStandingOrders.Insert(true);
            objMember.Reset;
            objMember.SetRange(objMember."No.", BosaAcNo);
            if objMember.Find('-') then begin
                phoneNumber := objMember."Phone No.";
                sms := 'You have created a standing order of amount : ' + Format(Amount) + ' from Account ' + SourceAcc + ' start date: '
                      + Format(StartDate) + '. Thanks for using AU INNOVATION SACCO Portal.';
                FnSMSMessage(SourceAcc, phoneNumber, sms);
                //MESSAGE('All Cool');
            end
        end;
     */

    /* procedure FnUpdateMonthlyContrib("Member No": Code[30]; "Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            FAccNo := objMember."FOSA Account No.";
            //  objMember."Monthly Contribution" := "Updated Fig";
            objMember.Modify;
            sms := 'You have adjusted your monthly contributions to: ' + Format("Updated Fig") + ' account number ' + FAccNo +
                  '. Thank you for using AU INNOVATION Sacco Portal';
            FnSMSMessage(FAccNo, phoneNumber, sms);

            //MESSAGE('Updated');
        end
    end;
 */

   /*  procedure FnSMSMessage(accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        //SMSMessages."Batch No":=documentNo;
        //SMSMessages."Document No":=documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'WEBPORTAL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;

 */
    /* procedure FnLoanApplication(Member: Code[30]; LoanProductType: Code[10]; AmountApplied: Decimal; LoanPurpose: Code[30]; RepaymentFrequency: Integer; LoanConsolidation: Boolean; LoanBridging: Boolean; LoanRefinancing: Boolean) Result: Boolean
    begin
        // objMember.RESET;
        // objMember.SETRANGE(objMember."No.", Member);
        // IF objMember.FIND('-') THEN BEGIN
        //
        //   objLoanApplication.RESET;
        //   objLoanApplication.INIT;
        //
        //   objLoanApplication.Type:=objLoanApplication.Type::"Loan Form";
        //    objLoanApplication.INSERT(TRUE);
        //   objLoanApplication."Account No":=Member;
        //   objLoanApplication.VALIDATE(objLoanApplication."Account No");
        //   objLoanApplication.VALIDATE(No);
        //
        //   objLoanApplication."Loan Type" :=LoanProductType;
        //
        //   objLoanApplication."Captured by":=USERID;
        //   objLoanApplication.Amount:=AmountApplied;
        //   objLoanApplication."Purpose of loan":=LoanPurpose;
        //   objLoanApplication."Repayment Period":=RepaymentFrequency;
        //   MESSAGE(objAtmapplication."Form No");
        //   objLoanApplication.VALIDATE("Loan Product Type");
        //   objLoanApplication."Loan Bridging":=LoanBridging;
        //   objLoanApplication."Loan Consolidation":=LoanConsolidation;
        //   objLoanApplication."Loan Refinancing":=LoanRefinancing;
        //   objLoanApplication.VALIDATE("Repayment Period");
        //   //objLoanApplication.VALIDATE("Loan Bridging");
        //   //objLoanApplication.VALIDATE("Loan Consolidation");
        //  // objLoanApplication.VALIDATE("Loan Refinancing");
        //   objLoanApplication.Submited:=TRUE;
        //   // objLoanApplication.INSERT(TRUE);
        //  objLoanApplication.MODIFY;
        //
        //
        // END;
        //
        // ***********insert******************
        // objLoanApplication.RESET;
        // objLoanApplication.SETRANGE(objLoanApplication."Account No", Member);
        // objLoanApplication.SETRANGE(objLoanApplication.Type,objLoanApplication.Type::"Loan Form");
        // //objLoanApplication.SETCURRENTKEY("Capture Date");
        // IF objLoanApplication.FINDLAST THEN
        //   FormNo:=objLoanApplication.No;
        //   objLoanApplication.SETRANGE(objLoanApplication.No,FormNo);
        //   IF objLoanApplication.FIND('-') THEN
        //     BEGIN
        //       objLoanRegister.INIT;
        //   MESSAGE(FormNo);
        //        objLoanRegister.INSERT(TRUE);
        //       objLoanRegister.Source:=objLoanRegister.Source::BOSA;
        //       //objLoanRegister.Installments:=RepaymentFrequency;
        //       MESSAGE(FORMAT(RepaymentFrequency));
        //       objLoanRegister."Captured By":=USERID;
        //       objLoanRegister."Select From Forms":=FormNo;
        //
        //      MESSAGE(objLoanRegister."Loan  No.");
        //       objLoanRegister.VALIDATE("Select From Forms");
        //      // objLoanRegister."Original Loan":=TRUE;
        //        objLoanRegister.VALIDATE("Requested Amount");
        //       objLoanRegister."Loan Status":=objLoanRegister."Loan Status"::Application;
        //      objLoanRegister.MODIFY;
        //       MESSAGE('here');
        //        Result:=TRUE;
        //        phoneNumber:=objMember."Phone No.";
        //        ClientName := objMember."FOSA Account No.";
        //        sms:='We have received your '+LoanProductType+' loan application of  amount : ' +FORMAT(AmountApplied)+
        //        '. We are processing your loan, you will hear from us soon. Thanks for using KENTOURS SACCO  Portal.';
        //        FnSMSMessage(ClientName,phoneNumber,sms);
        //        PortaLuPS.INIT;
        //       // PortaLuPS.INSERT(TRUE);
        //       objLoanRegister.RESET;
        //       objLoanRegister.SETRANGE("Client Code", Member);
        //       objLoanRegister.SETCURRENTKEY("Application Date");
        //       objLoanRegister.ASCENDING(TRUE);
        //       IF objLoanRegister.FINDLAST
        //         THEN
        //
        //          PortaLuPS.LaonNo:=objLoanRegister."Loan  No.";
        //        PortaLuPS.RequestedAmount:=AmountApplied;
        //        PortaLuPS.INSERT;
        //        //MESSAGE('All Cool');
        //      //MESSAGE('Am just cool');
        // END;
    end;
 */

    /*     procedure FnDepositsStatement("Account No": Code[30]; path: Text[100])
        var
            Filename: Text[100];
        begin
            Filename := FILESPATH + path;
            Message(FILESPATH);
            if Rec.Exists(Filename) then
                Erase(Filename);
            objMember.Reset;
            objMember.SetRange(objMember."No.", "Account No");

            if objMember.Find('-') then begin
                Report.SaveAsPdf(60354, Filename, objMember);
            end;
        end; */


    /*     procedure FnLoanStatement(MemberNo: Code[50]; var BigText: BigText)
        var
            Filename: Text[100];
            Convert: dotnet Convert;
            Path: dotnet Path;
            _File: dotnet File;
            FileAccess: dotnet FileAccess;
            FileMode: dotnet FileMode;
            MemoryStream: dotnet MemoryStream;
            FileStream: dotnet FileStream;
            Outputstream: OutStream;
        begin
            objMember.Reset;
            objMember.SetRange(objMember."No.", MemberNo);


            if objMember.Find('-') then begin
                //  objMember.SETFILTER("Date Filter", filter);
                Filename := Path.GetTempPath() + Path.GetRandomFileName();
                //Report.SaveAsPdf(50014, Filename, objMember);

                FileMode := 4;
                FileAccess := 1;

                FileStream := _File.Open(Filename, FileMode, FileAccess);

                MemoryStream := MemoryStream.MemoryStream();

                MemoryStream.SetLength(FileStream.Length);
                FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

                BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
                Message(Format(BigText));
                // exitString:=BigText;
                //MESSAGE(exitString);
                MemoryStream.Close();
                MemoryStream.Dispose();
                FileStream.Close();
                FileStream.Dispose();
                _File.Delete(Filename);

            end;
        end; */


    /* procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + ':' + objMember.Name + ':' + objMember."E-Mail" + ':' + Format(objMember.Status) + ':' + objMember."Mobile Phone No"
             + ':' + objMember."ID Number" + ':' + Format(objMember."Date Of Birth");
        end;
    end;

    procedure FnGetMemberProfile(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + ':' + objMember.Name + ':' + objMember."E-Mail" + ':' + Format(objMember.Status) + ':' + objMember."Mobile Phone No"
             + ':' + objMember."ID Number" + ':' + Format(objMember."Date Of Birth") + ':' + format(objMember."Payroll No") + ':' + Format(objMember.Gender) + ':' + Format(objMember.Pin) + ':'
             + Format(objMember."Country/Region Code") + ':' + Format(objMember.City) + ':' + Format(objMember."Registration Date") + ':' + Format(objMember."Bank Name") + ':'
             + Format(objMember."Bank Code") + ':' + Format(objMember."Bank Branch Name") + ':' + Format(objMember."Bank Branch Code") + ':' + Format(objMember."Bank Account No.");
        end;
    end;
 */
    /* procedure FnGetNOKProfile(MemberNo: Code[20]) info: Text
    var
        MembersNOK: Record "Members Next of Kin";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            MembersNOK.Reset();
            MembersNOK.SetRange("Account No", objMember."No.");
            if MembersNOK.Find('-') then begin
                info := Format(MembersNOK.Name) + ':' + Format(MembersNOK."ID No.") + ':' + Format(MembersNOK."Date of Birth") + ':' + Format(MembersNOK.Email) + ':' + Format(MembersNOK."%Allocation") + ':'
                + Format(MembersNOK.Relationship);
            end;
        end;
    end;

    procedure fnAccountInfo(Memberno: Code[20]) info: Text
    begin

        objMember.RESET;
        objMember.SETRANGE(objMember."No.", Memberno);

        IF objMember.FIND('-') THEN BEGIN
            objMember.CALCFIELDS("Shares Retained", "Current Savings");
            objMember.CALCFIELDS("Current Shares");
            info := FORMAT(ROUND(objMember."Current Savings" * -1, 0.01, '>')) + ':' + FORMAT(ROUND(objMember."Shares Retained", 0.01, '>'));

        END;
    end;

    /*     procedure FnGetMonthlyDeduction(IDNumber: Code[20]) Amount: Decimal
        var
            MembersRegister: Record Customer;
        begin
            Amount := 0;
            MembersRegister.Reset();
            MembersRegister.SetRange(MembersRegister."No.", IDNumber);
            if MembersRegister.Find('-') then begin
                MemberSaving.Reset();
                MemberSaving.SetRange(MemberSaving.MemberNo, MembersRegister."No.");

                if MemberSaving.FindSet() then begin

                    repeat

                        Amount += MemberSaving."Amount On";
                    until MemberSaving.Next = 0;
                end;
                loansregister.Reset();
                loansregister.SetRange("Client Code", MembersRegister."No.");
                loansregister.SetFilter("Outstanding Balance", '>%1', 0);
                if loansregister.FindSet() then begin
                    repeat
                        Amount += loansregister.Repayment;
                    until loansregister.Next = 0;
                end;
                exit(Amount);
            end; */






    // end; */

    /* procedure fnloaninfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        if objMember.Find('-') then begin

            info := Format(objMember."Outstanding Balance");
        end;
    end; */

    /* procedure fnMemberStatement(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        MemberStatement: Report 80007;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        // objMember.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
        if objMember.Find('-') then begin
            MemberStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end; */

    /* procedure fnPlots(MemberNo: Code[20]) plots: Text
    var

    begin
        Loanperiod := 0;
        PlotsRegister.Reset;
        PlotsRegister.SetRange("Client Code", MemberNo);
        PlotsRegister.Ascending(false);
        if PlotsRegister.Find('-') then begin
            repeat
                plots := plots + PlotsRegister."Client Name" + ':' + Format(PlotsRegister."Outstanding Balance") + ':' + PlotsRegister."Project Name" + ':' + Format(PlotsRegister."Plot No")
                + ':' + Format(PlotsRegister."Plot Amount") + '::';
            until PlotsRegister.Next() = 0;
        end;
    end; */

    /* procedure fnprojects() project: Text
    var

    begin
        Loanperiod := 0;
        Projects.Reset;
        Projects.Ascending(false);
        Projects.SetFilter("Plot Size",'<>%1','');
        if Projects.Find('-') then begin
            repeat
                project := project + Projects.Name + ':' + Format(Projects."Project Name") + ':' + Format(Projects."No of Plots") + ':' + Format(Projects."Plot Size")
                + ':' + Format(Projects.Cost) + '::';
            until Projects.Next() = 0;
        end;
    end; */

   /*  procedure FnloanCalc(LoanAmount: Decimal; RepayPeriod: Integer; LoanCode: Code[30]) text: Text
    begin
        /*Loansetup.RESET;
        Loansetup.SETRANGE(Code, LoanCode);

        IF Loansetup.FIND('-') THEN BEGIN

         IF Loansetup."Repayment Method"= Loansetup."Repayment Method"::Amortised THEN BEGIN
        // LoansRec.TESTFIELD(LoansRec.Interest);
        // LoansRec.TESTFIELD(LoansRec.Installments);
         TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - POWER((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
         LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.0001,'>');
         LPrincipal:=TotalMRepay-LInterest;
         END;

         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Straight Line" THEN BEGIN
         LoansRec.TESTFIELD(LoansRec.Interest);
         LoansRec.TESTFIELD(LoansRec.Installments);
         LPrincipal:=LoanAmount/RepayPeriod;
         LInterest:=(Loansetup."Interest rate"/12/100)*LoanAmount/RepayPeriod;
         END;

         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Reducing Balance" THEN BEGIN
         //LoansRec.TESTFIELD(LoansRec.Interest);
         //LoansRec.TESTFIELD(LoansRec.Installments);
         MESSAGE('type is %1',LoanCode);
          Date:=TODAY;
         //IF RepayPeriod>Loansetup."Band I Maximum" THEN BEGIN
           MESSAGE('HERE');
          TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - POWER((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
          REPEAT
         LInterest:=ROUND(LoanAmount * Loansetup."Interest rate"/12/100,0.0001,'>');
         LPrincipal:=TotalMRepay-LInterest;
           LoanAmount:=LoanAmount-LPrincipal;
        RepayPeriod:= RepayPeriod-1;

         text:=text+FORMAT(Date)+'!!'+FORMAT(ROUND( LPrincipal))+'!!'+FORMAT(ROUND( LInterest))+'!!'+FORMAT(ROUND(TotalMRepay))+'!!'+FORMAT(ROUND(LoanAmount))+'??';
         Date:=CALCDATE('+1M', Date);

         UNTIL RepayPeriod=0;
         END
          //
          END;
         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::Constants THEN BEGIN
         LoansRec.TESTFIELD(LoansRec.Repayment);
         IF LBalance < LoansRec.Repayment THEN
         LPrincipal:=LBalance
         ELSE
         LPrincipal:=LoansRec.Repayment;
         LInterest:=LoansRec.Interest;
         END;



         //END;

       //EXIT(Amount);
       //END;
       //END;*/

    //end;


    /* procedure Fnloanssetup() loanType: Text
    begin
        /*Loansetup.RESET;
        BEGIN
        loanType:='';
        REPEAT
        loanType:=FORMAT(Loansetup.Code)+':'+Loansetup."Product Description"+':::'+loanType;
          UNTIL Loansetup.NEXT=0;
        END;
        */

    //end;


  /*   procedure fnLoanDetails1(Loancode: Code[20]) loandetail: Text
    begin
        /*Loansetup.RESET;
        //Loansetup.SETRANGE(Code, Loancode);
        IF Loansetup.FIND('-') THEN BEGIN
          REPEAT
          loandetail:=loandetail+Loansetup."Product Description"+'!!'+ FORMAT(Loansetup."Repayment Method")+'!!'+FORMAT(Loansetup."Max. Loan Amount")+'!!'+FORMAT(Loansetup."Instalment Period")+'!!'+FORMAT(Loansetup."Interest rate")+'!!'
          +FORMAT(Loansetup."Repayment Frequency")+'??';
          UNTIL Loansetup.NEXT=0;
        END;
        */

    //end; */ 

    /*     procedure FnFeedback(MemberNo: Code[30]; TextMessage: Text[250]) isSaved: Boolean
        var
            Feedback: Record Response;
        begin
            Feedback.Init;
            Feedback.MemberNo := MemberNo;
            Feedback.Message := TextMessage;
            Feedback.ActionDate := CurrentDatetime;
            Feedback.Insert(true);
            isSaved := true;
        end; */


    /* procedure fnLoansPurposes() LoanType: Text
    begin
        LoansPurpose.Reset;
        begin
            LoanType := '';
            repeat
                LoanType := Format(LoansPurpose.Code) + ':' + LoansPurpose.Description + ':::' + LoanType;
            until LoansPurpose.Next = 0;
        end;
    end; */


    /* procedure fnReplys(No: Code[20]) text: Text
    begin
        // feedback.RESET;
        // feedback.SETRANGE(No, No);
        // feedback.SETCURRENTKEY(Entry);
        // feedback.ASCENDING(FALSE);
        // IF feedback.FIND('-') THEN BEGIN
        //   REPEAT
        //      IF(feedback.Reply ='') THEN BEGIN
        //
        //  END ELSE
        //     text:=text+FORMAT(feedback.DatePosted)+'!!'+feedback.Portalfeedback+'!!'+ feedback.Reply+'??';
        // UNTIL feedback.NEXT=0;
        // END;
    end; */


    /* procedure FnLoanfo(MemberNo: Code[20]) dividend: Text
    begin
        /*DivProg.RESET;
        DivProg.SETRANGE("Member No",MemberNo);
        IF DivProg.FIND('-') THEN BEGIN
          REPEAT
            IF DivProg."Gross Dividends" < 1 THEN DivProg."Gross Dividends":=-1*DivProg."Gross Dividends";
             IF DivProg."Net Dividends" < 1 THEN DivProg."Net Dividends":=-1*DivProg."Net Dividends";
             IF DivProg."Witholding Tax" < 1 THEN DivProg."Witholding Tax":=-1*DivProg."Witholding Tax";
             IF DivProg."Qualifying Shares" < 1 THEN DivProg."Qualifying Shares":=-1*DivProg."Qualifying Shares";
             IF DivProg.Shares < 1 THEN DivProg.Shares:=-1*DivProg.Shares;
            dividend:=dividend+FORMAT(DivProg.Date)+':::'+FORMAT( DivProg."Gross Dividends")+':::'+FORMAT(DivProg."Witholding Tax")+':::'+FORMAT(DivProg."Net Dividends")+':::'+FORMAT(DivProg."Qualifying Shares")+':::'
            +FORMAT(DivProg.Shares)+'::::';
            UNTIL DivProg.NEXT=0;
            END;
            */

    //end; */
 

    /*     procedure fnGetAtms(Idnumber: Code[20]) return: Text
        begin
            Vendor.Reset;
            objAtmapplication.SetRange("Customer ID", Idnumber);
            if objAtmapplication.Find('-') then begin
                repeat
                    return := objAtmapplication."No." + ':::' + return;
                until
                  objAtmapplication.Next = 0;
            end;
        end; */

    /* procedure fnRegister(MemberNo: Code[10]; Pass: Integer) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
        otp: Text;
    begin
        Registered := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange("Member No.", MemberNo);
        if OnlineUsers.Find('-') then begin
            // Reset Password
            otp := Format(Pass);
            OnlineUsers.Password := otp;
            OnlineUsers."Changed Password" := false;
            OnlineUsers."Date Created" := Today;
            if OnlineUsers.Modify(true) then
                smtpc.Create(OnlineUsers."Email Address", 'Utabibu Investment Member Portal Password Reset OTP', 'Your One Time Password To Access Utabibu Investment portal is: ' + otp, true);
            smtp.Send(smtpc, Enum::"Email Scenario"::Default);
            Registered := true;
            exit(Registered);

        end else begin
            //Error('Here');
            objMember.Reset();
            objMember.SetRange("No.", MemberNo);
            if objMember.Find('-') then begin
                //Register User In Online Table    
                otp := Format(Pass);
                OnlineUsers.Init();
                OnlineUsers."Member No." := objMember."No.";
                OnlineUsers."Member Name" := objMember.Name;
                OnlineUsers."ID Number" := objMember."ID Number";
                OnlineUsers.Password := otp;
                OnlineUsers."Changed Password" := false;
                OnlineUsers."Email Address" := objMember."E-Mail (Personal)";
                OnlineUsers."Date Created" := Today;
                if OnlineUsers.Insert(true) then
                    smtpc.Create(objMember."E-Mail", 'Utabibu Investment Member Portal OTP', 'Your one time password to access Utabibu Investment portal is: ' + otp, true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end else
                Error('You are currently not registered as member of Utabibu Investment! Please contact Utabibu Investment');
        end;
    end; */

   /*  procedure fnInsertOTP(MemberNo: Code[30]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange("Member No.", MemberNo);
        if OnlineUsers.Find('-') then begin
            OnlineOTP.Reset();
            OnlineOTP.SetRange("Member No", OnlineUsers."Member No.");
            if OnlineOTP.FindSet() then begin
                OnlineOTP."Member No" := OnlineUsers."Member No.";
                OnlineOTP."Member Name" := OnlineUsers."Member Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Modify(true) then
                    smtpc.Create(OnlineUsers."Email Address", 'Utafiti Sacco Member Portal Password Reset OTP', 'Your One Time Password To Access Utafiti Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end else begin
                OnlineOTP.Init();
                OnlineOTP."Member No" := OnlineUsers."Member No.";
                OnlineOTP."Member Name" := OnlineUsers."Member Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Insert(true) then
                    smtpc.Create(OnlineUsers."Email Address", 'Utafiti Sacco Member Portal Password Reset OTP', 'Your One Time Password To Access Utafiti Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;

        end;
    end; */


   /*  procedure fnResendOTP(MemberNo: Code[10]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange("Member No.", MemberNo);
        if OnlineUsers.Find('-') then begin
            OnlineOTP.Reset();
            OnlineOTP.SetRange("Member No", OnlineUsers."Member No.");
            if OnlineOTP.FindSet() then begin
                OnlineOTP."Member No" := OnlineUsers."Member No.";
                OnlineOTP."Member Name" := OnlineUsers."Member Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Modify(true) then
                    smtpc.Create(OnlineUsers."Email Address", 'Utabibu Investment Member Portal Password Reset OTP', 'Your One Time Password To Access Utabibu Investment portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;

        end;
    end; */

    /* procedure fnVerifyOTP(MemberNo: Code[10]; OTP: Integer) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineOTP.Reset();
        OnlineOTP.SetRange("Member No", MemberNo);
        //OnlineOTP.SetRange(OnlineOTP.OTP, OTP);
        OnlineOTP.SetRange(OnlineOTP.Authenticated, false);
        if OnlineOTP.FindFirst then begin
            OnlineOTP.Authenticated := true;
            if OnlineOTP.Modify(true) then
                Registered := true;
            exit(Registered);
        end;
    end; */

    /* procedure FnSendFeedback(MemberNo: Code[10]; Body: Text) Sent: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
        otp: Text;
    begin
        Sent := false;
        objMember.Reset();
        objMember.SetRange("No.", MemberNo);
        if objMember.Find('-') then begin
            smtpc.Create('utafiti@cgiar.org', 'Utabibu Investment Member Portal Feedback', Body, true);
            smtp.Send(smtpc, Enum::"Email Scenario"::Default);
            Sent := true;
            exit(Sent);
        end;
    end; */

    /* procedure fnConfirmRegistration(MemberNo: Code[40]; otp: Text; newpassword: Text) status: Boolean
    begin
        status := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange(OnlineUsers."Member No.", MemberNo);
        OnlineUsers.SetRange(OnlineUsers."Changed Password", false);
        if OnlineUsers.Find('-') then begin
            OnlineUsers.Password := newpassword;
            OnlineUsers."Changed Password" := true;
            if OnlineUsers.Modify(true) then
                status := true;
            exit(status);
        end
        else
            exit(status);
    end; */

    /* procedure fnRegisterNewMember(name: Text; postcode: Code[40]; idnumber: Code[40]; krapin: Code[50]; maritalstatus: Integer; gender: Integer; dateofbirth: Date; phoneno: Code[50]; email: Text; hometown: Text; contactpersonname: Code[250]; contactpersonRelation: Code[50]; contactpersonphone: Code[50]; contactpersonoccupation: Text) no: Code[60]
    begin

        /*setup.GET;
        memberApp.INIT;
        memberApp."No.":=noseries.GetNextNo(setup."Members Nos",TODAY, TRUE);
        memberApp.Name:=name;
        memberApp.VALIDATE(memberApp.Name);
        memberApp."Account Category":=memberApp."Account Category"::Individual;
        memberApp."Postal Code":=postcode;
        memberApp."ID No.":=idnumber;
        memberApp."KRA Pin":=krapin;
        memberApp."Marital Status":=maritalstatus;
        memberApp.Gender:=gender;
        memberApp."Date of Birth":=dateofbirth;
        memberApp."Mobile Phone No":=phoneno;
        memberApp."E-Mail (Personal)":=email;
        memberApp."Home Town":=hometown;
        memberApp."Contact Person":=contactpersonname;
        memberApp."Contact Person Phone":=contactpersonphone;
        memberApp."ContactPerson Relation":=contactpersonRelation;
        memberApp."ContactPerson Occupation":=contactpersonoccupation;
        memberApp.Source:=memberApp.Source::Portal;
        memberApp."Customer Posting Group":='MEMBER';
        memberApp."Global Dimension 1 Code":='BOSA';
        memberApp."Global Dimension 2 Code":='NAIROBI';
        memberApp.INSERT;
        no:=memberApp."No.";
        */

    //end; */

    /*     procedure fnPostalCodes() returnout: Text
        var
            jsonout: dotnet String;
            zipcodes: Record "Post Code";
        begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            if zipcodes.Find('-') then begin
                JSONTextWriter.WriteStartArray;
                repeat
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('value', zipcodes.Code);
                    CreateJsonAttribute('name', zipcodes.City);
                    JSONTextWriter.WriteEndObject;
                until zipcodes.Next = 0;

                JSONTextWriter.WriteEndArray;
            end;
            jsonout := StringBuilder.ToString;
            returnout := Format(jsonout);
        end; */

    /*     local procedure CreateJsonAttribute(Attributename: Text; Value: Variant)
        begin
            JSONTextWriter.WritePropertyName(Attributename);
            JSONTextWriter.WriteValue(Format(Value));
        end;

        procedure fnMemberProfile(member: Code[50]) returnout: Text
        var
            jsonout: dotnet String;
            startyear: Integer;
            endyear: Integer;
            transactions: Record "Member Ledger Entry";
            counter: Integer;
            gurantorCoutner: Integer;
            loanproducts: Record "Loan Products Setup";
            loans: Record "Loans Register";
            signatories: Record "Members Next of Kin";
        begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            objMember.Reset;
            objMember.SetRange("No.", member);
            if objMember.Find('-') then begin
                objMember.CalcFields(objMember."Shares Retained", objMember."Current Shares", "Dividend Amount", "Outstanding Balance");
                JSONTextWriter.WriteStartObject;
                ///start
                CreateJsonAttribute('Name', objMember.Name);
                CreateJsonAttribute('postCode', objMember."Post Code");
                CreateJsonAttribute('idNumber', objMember."ID No.");
                CreateJsonAttribute('maritalStatus', objMember."Marital Status");
                CreateJsonAttribute('gender', Format(objMember.Gender));
                JSONTextWriter.WritePropertyName('dateOfBirth');
                JSONTextWriter.WriteValue(objMember."Date of Birth");
                CreateJsonAttribute('phoneNo', objMember."Mobile Phone No");
                CreateJsonAttribute('email', objMember."E-Mail (Personal)");
                CreateJsonAttribute('homeTown', objMember."Home Town");
                CreateJsonAttribute('payrollNo', '');
                CreateJsonAttribute('contactPersonName', objMember."Contact Person");
               // CreateJsonAttribute('contactPersonRelation', objMember."ContactPerson Relation");
                //CreateJsonAttribute('contactPersonPhone', objMember."ContactPerson Relation");
                JSONTextWriter.WritePropertyName('sharesRetained');
                JSONTextWriter.WriteValue(objMember."Shares Retained");
                JSONTextWriter.WritePropertyName('holidaySavings');
                //JSONTextWriter.WriteValue(objMember."Holiday Savings");
                JSONTextWriter.WritePropertyName('propertySavings');
                //JSONTextWriter.WriteValue(objMember."Utafiti Housing");
                JSONTextWriter.WritePropertyName('outstandingBalance');
                JSONTextWriter.WriteValue(objMember."Outstanding Balance");
                JSONTextWriter.WritePropertyName('dividendAmount');
                JSONTextWriter.WriteValue(objMember."Dividend Amount");
                JSONTextWriter.WritePropertyName('juniorSavings');
                //JSONTextWriter.WriteValue(objMember."Dependant Savings 1");
                JSONTextWriter.WritePropertyName('insuranceContribution');
                JSONTextWriter.WriteValue(0);
                JSONTextWriter.WritePropertyName('currentShares');
                JSONTextWriter.WriteValue(objMember."Current Shares");
                JSONTextWriter.WritePropertyName('outstandingBalance');
                JSONTextWriter.WriteValue(objMember."Outstanding Balance");
                JSONTextWriter.WritePropertyName('dividendAmount');
                JSONTextWriter.WriteValue(objMember."Dividend Amount");
                JSONTextWriter.WritePropertyName('outstandingInterest');
                //JSONTextWriter.WriteValue(objMember."Outstanding Interest");
                JSONTextWriter.WritePropertyName('QualifyingAmount');
                JSONTextWriter.WriteValue((objMember."Current Shares") * 3 - objMember."Outstanding Balance");


                // Bank details
                //customerBankDetails.RESET;
                // customerBankDetails.SETRANGE("Customer No.", objMember."No.");
                //IF customerBankDetails.FIND('-') THEN BEGIN
                CreateJsonAttribute('bankAccountNo', '');
                CreateJsonAttribute('bankName', '');
                CreateJsonAttribute('bankBranch', '');
                // END;

                //Grapsh
                JSONTextWriter.WritePropertyName('graphHeader');
                JSONTextWriter.WriteStartArray;
                JSONTextWriter.WriteStartArray;
                JSONTextWriter.WriteValue('x');
                loanproducts.Reset;
                if loanproducts.Find('-') then begin
                    repeat
                        loans.Reset;
                        loans.SetRange("Client Code", objMember."No.");
                        loans.SetRange(Posted, true);
                        loans.SetRange("Loan Product Type", loanproducts.Code);
                        if loans.Find('-') then begin
                            //REPEAT
                            loans.CalcFields("Outstanding Balance");
                            //IF loans."Outstanding Balance">0 THEN
                            JSONTextWriter.WriteValue(loans."Loan Product Type");
                            //UNTIL loans.NEXT=0;
                        end;
                    until loanproducts.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndArray;

                //Graph data

                JSONTextWriter.WritePropertyName('graphData');

                JSONTextWriter.WriteStartArray;
                startyear := Date2dmy(20100101D, 3);
                endyear := Date2dmy(Today, 3) + 1;
                repeat

                    JSONTextWriter.WriteStartArray;
                    JSONTextWriter.WriteValue(startyear);


                    loanproducts.Reset;
                    if loanproducts.Find('-') then begin
                        repeat
                            loans.Reset;
                            loans.SetRange("Client Code", objMember."No.");
                            loans.SetRange(Posted, true);

                            loans.SetRange("Loan Product Type", loanproducts.Code);
                            loans.SetRange(loans."Date filter", Dmy2date(1, 1, startyear), Dmy2date(31, 12, startyear));
                            if loans.Find('-') then begin
                                //REPEAT
                                loans.CalcFields("Outstanding Balance");
                                //IF loans."Outstanding Balance">0 THEN
                                JSONTextWriter.WriteValue(Abs(loans."Outstanding Balance"));
                                //UNTIL loans.NEXT=0;
                            end;// ELSE
                                //JSONTextWriter.WriteValue(500);
                        until loanproducts.Next = 0;
                    end;


                    /*
                    JSONTextWriter.WriteValue(1000);
                    JSONTextWriter.WriteValue(4000);

                    JSONTextWriter.WriteValue(18000);
                    JSONTextWriter.WriteValue(40000);
                    */
    /*  JSONTextWriter.WriteEndArray;

     startyear := startyear + 1;
 until startyear = endyear;
 JSONTextWriter.WriteEndArray;




 ///Kindata
 JSONTextWriter.WritePropertyName('kindata');
 JSONTextWriter.WriteStartArray;

 //end kin data

 JSONTextWriter.WriteEndArray;


 ///transactions

 JSONTextWriter.WritePropertyName('transactions');
 JSONTextWriter.WriteStartArray;
 transactions.Reset;
 transactions.SetRange("Customer No.", objMember."No.");
 transactions.SetCurrentkey(transactions."Posting Date");
 transactions.Ascending(false);
 if transactions.Find('-') then begin
     counter := 0;
     repeat
         JSONTextWriter.WriteStartObject;
         JSONTextWriter.WritePropertyName('id');
         JSONTextWriter.WriteValue(transactions."Entry No.");
         JSONTextWriter.WritePropertyName('date');
         JSONTextWriter.WriteValue(transactions."Posting Date");
         CreateJsonAttribute('transaction', Format(transactions."Transaction Type"));
         CreateJsonAttribute('description', transactions.Description);
         JSONTextWriter.WritePropertyName('amount');
         JSONTextWriter.WriteValue(Abs(transactions.Amount));

         JSONTextWriter.WriteEndObject;
         counter := counter + 1;
         if counter = 10 then break;
     until transactions.Next = 0;

 end;
 JSONTextWriter.WriteEndArray;
 gurantorCoutner := 0;
 ////My guarantors
 JSONTextWriter.WritePropertyName('GuaranteeDetails');
 JSONTextWriter.WriteStartArray;
 LoansGuaranteeDetails.Reset;
 LoansGuaranteeDetails.SetRange("Member No", objMember."No.");

 if LoansGuaranteeDetails.Find('-') then begin

     repeat
         LoansGuaranteeDetails.CalcFields("Outstanding Balance");
         if LoansGuaranteeDetails."Outstanding Balance" <> 0 then begin
             gurantorCoutner += 1;
             JSONTextWriter.WriteStartObject;
             JSONTextWriter.WritePropertyName('id');
             JSONTextWriter.WriteValue(gurantorCoutner);
             CreateJsonAttribute('memberNo', LoansGuaranteeDetails."Loanees  No");
             CreateJsonAttribute('name', LoansGuaranteeDetails."Loanees  Name");
             CreateJsonAttribute('loanNo', LoansGuaranteeDetails."Loan No");
             JSONTextWriter.WritePropertyName('guaranteedAmount');
             JSONTextWriter.WriteValue(LoansGuaranteeDetails."Amont Guaranteed");
             JSONTextWriter.WritePropertyName('loanAmount');
             JSONTextWriter.WriteValue(LoansGuaranteeDetails."Outstanding Balance");
             CreateJsonAttribute('type', 'Guarantor');

             JSONTextWriter.WriteEndObject;
         end;
     until LoansGuaranteeDetails.Next = 0;
 end;

 //Guaranteed
 LoansGuaranteeDetails.Reset;
 LoansGuaranteeDetails.SetRange("Loanees  No", objMember."No.");

 if LoansGuaranteeDetails.Find('-') then begin

     repeat
         LoansGuaranteeDetails.CalcFields("Outstanding Balance");
         if LoansGuaranteeDetails."Outstanding Balance" <> 0 then begin
             gurantorCoutner += 1;
             JSONTextWriter.WriteStartObject;
             JSONTextWriter.WritePropertyName('id');
             JSONTextWriter.WriteValue(gurantorCoutner);
             CreateJsonAttribute('memberNo', LoansGuaranteeDetails."Member No");
             CreateJsonAttribute('name', LoansGuaranteeDetails.Name);
             CreateJsonAttribute('loanNo', LoansGuaranteeDetails."Loan No");
             JSONTextWriter.WritePropertyName('guaranteedAmount');
             JSONTextWriter.WriteValue(LoansGuaranteeDetails."Amont Guaranteed");
             JSONTextWriter.WritePropertyName('loanAmount');
             JSONTextWriter.WriteValue(LoansGuaranteeDetails."Outstanding Balance");
             CreateJsonAttribute('type', 'Guaranteed');
             JSONTextWriter.WriteEndObject;
         end;
     until LoansGuaranteeDetails.Next = 0;
 end;
 JSONTextWriter.WriteEndArray;
 ///Signatories

 JSONTextWriter.WritePropertyName('signatories');
 JSONTextWriter.WriteStartArray;

 signatories.Reset;
 signatories.SetRange(signatories."Account No", objMember."No.");
 if signatories.Find('-') then begin

     repeat
         JSONTextWriter.WriteStartObject;
         CreateJsonAttribute('names', signatories.Name);
         CreateJsonAttribute('idno', signatories."ID No.");
         JSONTextWriter.WritePropertyName('dateOfBirth');
         JSONTextWriter.WriteValue(signatories."Date of Birth");
         CreateJsonAttribute('email', signatories.Email);
         JSONTextWriter.WriteEndObject;
     until signatories.Next = 0;

 end;

 JSONTextWriter.WriteEndArray;
 ///Loans
 JSONTextWriter.WritePropertyName('loans');
 JSONTextWriter.WriteStartArray;

 loans.Reset;
 loans.SetRange(loans."Client Code", objMember."No.");
 // JSONTextWriter.WriteStartArray;
 if loans.Find('-') then begin
     repeat
         JSONTextWriter.WriteStartObject;
         CreateJsonAttribute('id', loans."Loan  No.");
         CreateJsonAttribute('loanProduct', loans."Loan Product Type");
         //if loans."Loan Status" = loans."Loan Status"::Disbursed then
             //CreateJsonAttribute('status', Format('Issued')) else
          //   CreateJsonAttribute('status', Format(loans."Loan Status"));
         JSONTextWriter.WritePropertyName('applicationDate');
         JSONTextWriter.WriteValue(loans."Application Date");
         JSONTextWriter.WritePropertyName('requestedAmount');
         JSONTextWriter.WriteValue(loans."Requested Amount");
         loans.CalcFields(loans."Outstanding Balance");
         JSONTextWriter.WritePropertyName('remainingAmount');
         JSONTextWriter.WriteValue(loans."Outstanding Balance");
         JSONTextWriter.WritePropertyName('repayment');
         //JSONTextWriter.WriteValue(loans.Repayment);
         JSONTextWriter.WritePropertyName('repayment');
         //JSONTextWriter.WriteValue(loans.Repayment);
         JSONTextWriter.WriteEndObject;
     until loans.Next = 0;


 end;

 JSONTextWriter.WriteEndArray;

 ///end
 JSONTextWriter.WriteEndObject;
end;


jsonout := StringBuilder.ToString;
returnout := Format(jsonout);

end; */

    /*     procedure fnLoanProducts() returnout: Text
        var
           // jsonout: dotnet String;
        begin

            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

            loanproducts.RESET;
            IF loanproducts.FIND('-') THEN BEGIN
                JSONTextWriter.WriteStartArray;
                REPEAT
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('code', loanproducts.Code);
                    CreateJsonAttribute('description', loanproducts."Product Description");
                    JSONTextWriter.WritePropertyName('interest');
                    JSONTextWriter.WriteValue(loanproducts."Interest rate");
                    JSONTextWriter.WritePropertyName('maxInstallments');
                    JSONTextWriter.WriteValue(loanproducts."Default Installements");
                    JSONTextWriter.WritePropertyName('maxAmount');
                    JSONTextWriter.WriteValue(loanproducts."Max. Loan Amount");
                    JSONTextWriter.WritePropertyName('minAmount');
                    JSONTextWriter.WriteValue(loanproducts."Min. Loan Amount");
                    JSONTextWriter.WriteEndObject;
                UNTIL loanproducts.NEXT = 0;
                JSONTextWriter.WriteEndArray;

            END;
            //jsonout := StringBuilder.ToString;
            //returnout := FORMAT(jsonout);


        end; */

   /*  procedure FnLoanApplicationNew(memberno: Code[50]; product: Code[60]; installments: Integer; amount: Decimal) loanno: Code[40]
    begin
        /*
        loansreg.INIT;
        SaccoNoSeries.GET;
        loanssetup.GET;
        loansreg."Loan  No.":=noseries.GetNextNo(SaccoNoSeries."BOSA Loans Nos", TODAY, TRUE);
        loansreg.INSERT(TRUE);
        loansreg."Client Code":=memberno;
        loansreg.VALIDATE(loansreg."Client Code");
        loansreg."Loan Product Type":=product;
        loansreg.VALIDATE(loansreg."Loan Product Type");
        loansreg."Requested Amount":=amount;
        loansreg.VALIDATE(loansreg."Requested Amount");
        loansreg.Installments:=installments;
        loansreg.VALIDATE(loansreg.Installments);
        loansreg."Repayment Frequency":=loanssetup."Repayment Frequency";
        loansreg.VALIDATE(loansreg."Repayment Frequency");
        loansreg."Repayment Method":=loanssetup."Repayment Method";
        loansreg.VALIDATE(loansreg."Repayment Method");
        loansreg.ApplicationSource:=loansreg.ApplicationSource::Portal;
        loansreg.MODIFY;

        loanno:=loansreg."Loan  No.";
        */

  /*   end;

    procedure fnInsertGuarantors(memberNo: Code[50]; amount: Decimal; guarantor: Code[60]; loanno: Code[60])
    begin */
        /*
        LoansGuaranteeDetails.INIT;
        LoansGuaranteeDetails."Loan No":=loanno;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loan No");
        LoansGuaranteeDetails."Member No":=guarantor;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Member No");
        LoansGuaranteeDetails.RequestedGuarantee:=amount;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Amont Guaranteed");
        LoansGuaranteeDetails."Loanees  No":=memberNo;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loanees  No");
        LoansGuaranteeDetails.INSERT(TRUE);
        */

   // end;

    /* procedure fnApproveGuarantors(loanee: Code[60]; amount: Decimal; approval: Boolean; loanno: Code[60]; memberno: Code[50])
    begin
        /*
        LoansGuaranteeDetails.RESET;
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Loan No", loanno);
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Member No", loanee);
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Loanees  No", memberno);
        IF LoansGuaranteeDetails.FIND('-') THEN BEGIN
          LoansGuaranteeDetails.approved:=approval;
          LoansGuaranteeDetails."Amont Guaranteed":=amount;
          IF LoansGuaranteeDetails.approved=TRUE THEN BEGIN
            LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Amont Guaranteed");
            LoansGuaranteeDetails.MODIFY;
            END
            ELSE BEGIN
            LoansGuaranteeDetails.DELETE;
            END;
        END;
        */

   // end; 

    /* procedure fnPendingGurarantorship(no: Code[60]) returnout: Text
    var
        gurantorCoutner: Integer;
    //loansreg: Record UnknownRecord170300;
    // jsonout: dotnet String;
    begin
        /*
        StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
          LoansGuaranteeDetails.RESET;
          LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Member No", no);

          LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails.approved, FALSE);

          IF LoansGuaranteeDetails.FIND('-') THEN BEGIN
         gurantorCoutner:=0;
             JSONTextWriter.WriteStartArray;
         REPEAT
           loansreg.RESET;
           loansreg.SETRANGE(loansreg."Loan  No.", LoansGuaranteeDetails."Loan No");
           loansreg.SETRANGE(loansreg."Loan Status",  loansreg."Loan Status"::Application);
           IF loansreg.FIND('-') THEN BEGIN

          // LoansGuaranteeDetails.CALCFIELDS("Outstanding Balance");
         //  IF LoansGuaranteeDetails."Outstanding Balance" <> 0 THEN BEGIN
           gurantorCoutner+=1;
            JSONTextWriter.WriteStartObject;
           JSONTextWriter.WritePropertyName('id');
           JSONTextWriter.WriteValue(gurantorCoutner);
           CreateJsonAttribute('memberNo', loansreg."Client Code");
           CreateJsonAttribute('name', loansreg."Client Name");
           CreateJsonAttribute('loanNo', LoansGuaranteeDetails."Loan No");
           JSONTextWriter.WritePropertyName('guaranteedAmount');
           JSONTextWriter.WriteValue(LoansGuaranteeDetails.RequestedGuarantee);
           JSONTextWriter.WritePropertyName('loanAmount');
           JSONTextWriter.WriteValue(loansreg."Requested Amount");
           CreateJsonAttribute('type', 'Guaranteed');
           JSONTextWriter.WriteEndObject;
          // END;
           END;
         UNTIL LoansGuaranteeDetails.NEXT=0;
         JSONTextWriter.WriteEndArray;
         END;
         jsonout:=StringBuilder.ToString;
         returnout:=FORMAT(jsonout);
         */

    //end;
 
    /*     procedure fnInsertAttachments(Extension: Text; File: BigText; DocumentNo: Code[49]; Description: Text)
        var
            Bytes: dotnet Array;
            Convert: dotnet Convert;
            MemoryStream: dotnet MemoryStream;
            Ostream: OutStream;
            counter: Integer;
            FName: dotnet String;
            Seperator: dotnet String;
            Values: dotnet Array;
            Value: Char;
            Fileset: Text;
            attachments: Record Attachment;
            attachments2: Record Attachment;
            inttemplate: Record "Interaction Tmpl. Language";
        begin
            /*
            {
            FName:=Description;
            Seperator:='.';
            Values:=FName.Split(Seperator.ToCharArray());
            counter:=1;
            FOREACH Value IN Values DO BEGIN
              Fileset[counter]:=Value;
              counter:=counter+1;
              END;
              }
            documents.INIT;
            documents2.SETCURRENTKEY("Attachment No.");
            documents2.ASCENDING:=TRUE;
            IF documents2.FINDLAST THEN
            documents."Attachment No.":=documents2."Attachment No."+1
             ELSE
            documents."Attachment No.":=1;
            documents."Doc No.":=DocumentNo;
            documents."Document Description":=Description;
            documents.VALIDATE("Document Description");
            documents.Attachment:=documents.Attachment::Yes;

            attachments.INIT;
            attachments."No.":=documents."Attachment No.";
            attachments."File Extension":=Extension;

            attachments.INSERT;
            attachments2.RESET;
            attachments2.GET(documents."Attachment No.");
            Bytes:=Convert.FromBase64String(File);
            MemoryStream:=MemoryStream.MemoryStream(Bytes);
            attachments2."Attachment File".CREATEOUTSTREAM(Ostream);
            MemoryStream.WriteTo(Ostream);
            attachments2.MODIFY;
            //END;
            inttemplate.INIT;
            inttemplate."Attachment No.":=documents."Attachment No.";
            inttemplate."Interaction Template Code":=DocumentNo;
            inttemplate."Language Code":=FORMAT(documents2."Attachment No."+1);
            inttemplate.Description:=Description;
            inttemplate.INSERT;

            documents.INSERT;
            */

    //  end; */

    /*    procedure fnLoanDetails(loanno: Code[60]) returnout: Text
       var
          // jsonout: dotnet String;
       begin

           StringBuilder := StringBuilder.StringBuilder;
           StringWriter := StringWriter.StringWriter(StringBuilder);
           JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

           loansregister.RESET;
           //loansregister.SETRANGE("Loan  No.", loanno);

           IF loansregister.FIND('-') THEN BEGIN
               JSONTextWriter.WriteStartObject;
               //CreateJsonAttribute('loanNo', loansregister."Loan  No.");
               CreateJsonAttribute('memberNo', loansregister."Client Code");
               //CreateJsonAttribute('loanProduct', loansregister."Loan Product Type Name");
               JSONTextWriter.WritePropertyName('requestedAmount');
               //JSONTextWriter.WriteValue(loansregister."Requested Amount");
               JSONTextWriter.WritePropertyName('approvedAmount');
               //JSONTextWriter.WriteValue(loansregister."Approved Amount");
               //CreateJsonAttribute('status', FORMAT(loansregister."Loan Status"));
               JSONTextWriter.WritePropertyName('interest');
               //JSONTextWriter.WriteValue(loansregister."loan  Interest");
               //CreateJsonAttribute('repaymentFrequency', FORMAT(loansregister."Repayment Frequency"));
               JSONTextWriter.WritePropertyName('repaymentStartDate');
               //JSONTextWriter.WriteValue(loansregister."Repayment Start Date");
               JSONTextWriter.WritePropertyName('repayment');
               //JSONTextWriter.WriteValue(loansregister.Repayment);
               JSONTextWriter.WritePropertyName('expectedCompletionDate');
               //JSONTextWriter.WriteValue(loansregister."Expected Date of Completion");
               JSONTextWriter.WritePropertyName('amount');
               //JSONTextWriter.WriteValue(loansregister."Amount Disbursed");
               JSONTextWriter.WritePropertyName('installments');
              // JSONTextWriter.WriteValue(loansregister.Installments);
               JSONTextWriter.WritePropertyName('guarantors');
               JSONTextWriter.WriteStartArray;
               loansguarantee.RESET;
              // loansguarantee.SETRANGE("Loan No", loansregister."Loan  No.");
               IF loansguarantee.FIND('-') THEN BEGIN
                   REPEAT
                       JSONTextWriter.WriteStartObject;
                       CreateJsonAttribute('id', loansguarantee."Member No");
                       CreateJsonAttribute('memberno', loansguarantee."Member No");
                       CreateJsonAttribute('loanee', loansguarantee.Name);
                       JSONTextWriter.WritePropertyName('amount');
                       JSONTextWriter.WriteValue(loansguarantee."Amont Guaranteed");
                       JSONTextWriter.WriteEndObject;
                   UNTIL loansguarantee.NEXT = 0;

               END;
               /*JSONTextWriter.WriteEndArray;
               JSONTextWriter.WritePropertyName('salary');
               JSONTextWriter.WriteStartArray;
               loanssalary.RESET;
               loanssalary.SETRANGE("Loan No", loansregister."Loan  No.");
               IF loanssalary.FIND('-') THEN BEGIN
                   REPEAT
                       JSONTextWriter.WriteStartObject;
                       CreateJsonAttribute('id', loanssalary.Code);
                       CreateJsonAttribute('description', loanssalary.Description);
                       JSONTextWriter.WritePropertyName('amount');
                       JSONTextWriter.WriteValue(loanssalary.Amount);
                       JSONTextWriter.WriteEndObject;
                   UNTIL loanssalary.NEXT = 0;
                   JSONTextWriter.WriteEndArray;


               END;*/
    //  JSONTextWriter.WriteEndObject;
    //END;
    //  jsonout := StringBuilder.ToString;
    //  returnout := FORMAT(jsonout);


    //  end; */

    /*     procedure fnAllMembers() returnout: Text
        var
            jsonout: dotnet String;
        begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            objMember.Reset;
            JSONTextWriter.WriteStartArray;
            objMember.SetRange(Status, objMember.Status::Active);
            if objMember.Find('-') then begin
                repeat
                    JSONTextWriter.WriteStartObject;
                    ///start
                    CreateJsonAttribute('Name', objMember.Name);
                    CreateJsonAttribute('no', objMember."No.");
                    JSONTextWriter.WriteEndObject;
                until objMember.Next = 0;
            end;

            JSONTextWriter.WriteEndArray;
            jsonout := StringBuilder.ToString;
            returnout := Format(jsonout);
        end; */ 

    /* procedure fnRelationShips() returnout: Text
    var
    // jsonout: dotnet String;
    begin
        /*
        StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        objMember.RESET;
        JSONTextWriter.WriteStartArray;
        //objMember.SETRANGE(Status, objMember.Status::Active);
        IF relationships.FIND('-') THEN BEGIN
          REPEAT
          JSONTextWriter.WriteStartObject;
          ///start
          CreateJsonAttribute('name', relationships.Describution);
          CreateJsonAttribute('value', relationships.code);
          JSONTextWriter.WriteEndObject;
          UNTIL relationships.NEXT=0;
          END;

        JSONTextWriter.WriteEndArray;
        jsonout:=StringBuilder.ToString;
         returnout:=FORMAT(jsonout);
         */

   // end;
 
    /* procedure FnInsertGuarantorsTest(memberNo: Code[50]; amount: Decimal; guarantor: Code[60])
    begin

        /*
        LoansGuaranteeDetails.INIT;
        LoansGuaranteeDetails."Loan No":=noseries.GetNextNo(SaccoNoSeries."BOSA Loans Nos", TODAY, TRUE);
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loan No");
        LoansGuaranteeDetails."Member No":=guarantor;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Member No");
        LoansGuaranteeDetails.RequestedGuarantee:=amount;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Amont Guaranteed");
        LoansGuaranteeDetails."Loanees  No":=memberNo;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loanees  No");
        LoansGuaranteeDetails.INSERT(TRUE);
        */

    //end;

    /*     procedure fnNotifications() returnout: Text
        var
            notifications: Record Notification;
            jsonout: dotnet String;
        begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            objMember.Reset;
            JSONTextWriter.WriteStartArray;
            //objMember.SETRANGE(Status, objMember.Status::Active);
            notifications.SetCurrentkey(notifications."Entry Date");
            notifications.Ascending(false);
            if notifications.Find('-') then begin
                repeat
                    JSONTextWriter.WriteStartObject;
                    ///start
                    CreateJsonAttribute('message', notifications.Notification);
                    JSONTextWriter.WritePropertyName('dateTime');
                    JSONTextWriter.WriteValue(notifications."Entry Date");
                    CreateJsonAttribute('author', notifications."Entered by");
                    JSONTextWriter.WriteEndObject;
                until notifications.Next = 0;
            end;

            JSONTextWriter.WriteEndArray;
            jsonout := StringBuilder.ToString;
            returnout := Format(jsonout);
        end; */

    /*     procedure fnGetFeedback(member: Code[50]) returnout: Text
        var
          //  notifications: Record Feedback;
           // jsonout: dotnet String;
        begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            //objMember.RESET;
            JSONTextWriter.WriteStartArray;
            //objMember.SETRANGE(Status, objMember.Status::Active);
            notifications.SetRange(notifications."Member No.", member);
            notifications.SetCurrentkey(notifications."Action Date");
            notifications.Ascending(true);
            if notifications.Find('-') then begin
                repeat
                    JSONTextWriter.WriteStartObject;
                    ///start
                    CreateJsonAttribute('message', notifications.Message);
                    JSONTextWriter.WritePropertyName('dateTime');
                    JSONTextWriter.WriteValue(notifications."Action Date");
                    CreateJsonAttribute('reply', notifications.Response);
                    JSONTextWriter.WriteEndObject;
                until notifications.Next = 0;
            end;

            JSONTextWriter.WriteEndArray;
            jsonout := StringBuilder.ToString;
            returnout := Format(jsonout);
        end; */

    /* procedure Fnlogin(MemberNo: Code[20]; password: Text) LoggedIn: Boolean
    begin
        LoggedIn := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange(OnlineUsers."Member No.", MemberNo);
        OnlineUsers.SetRange(Password, password);
        OnlineUsers.SetRange("Changed Password", true);
        if OnlineUsers.Find('-') then begin
            LoggedIn := true;
            exit(LoggedIn);
        end
        else
            exit(LoggedIn);
    end; */

  /*   procedure fngetEmail(MemberNo: Code[20]) LoggedIn: text
    begin

        OnlineUsers.Reset;
        OnlineUsers.SetRange(OnlineUsers."Member No.", MemberNo);

        if OnlineUsers.Find('-') then begin
            LoggedIn := OnlineUsers."Email Address";
            exit(LoggedIn);
        end
        else
            exit(LoggedIn);
    end;
  */
//}

  