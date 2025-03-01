//<---------------------------------------------------------------------->															
Report 180007 "Member Account Statement(Ver1)"
{
    RDLCLayout = 'Layouts/MemberAccountStatement(Ver1).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Outstanding Balance", "Date Filter";
            column(UserId; UserId)
            {
            }
            column(PayrollStaffNo_Members; Customer."Payroll No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(PageNo_Members; CurrReport.PageNo())
            {

            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }

            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            dataitem(ShareCapital; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Share Capital"));
                column(ReportForNavId_1000000009; 1000000009) { } // Autogenerated by ForNav - Do not delete															
                column(PostingDate_ShareCapital; ShareCapital."Posting Date")
                {
                }
                column(DocumentNo_ShareCapital; ShareCapital."Document No.")
                {
                }
                column(Customer_No_Sc; ShareCapital."Customer No.")
                {
                }
                column(Description_ShareCapital; ShareCapital.Description)
                {
                }
                column(DebitAmount_ShareCapital; ShareCapital."Debit Amount")
                {
                }
                column(CreditAmount_ShareCapital; ShareCapital."Credit Amount")
                {
                }
                column(Amount_ShareCapital; ShareCapital.Amount)
                {
                }
                column(TransactionType_ShareCapital; ShareCapital."Transaction Type")
                {
                }
                column(UserID_ShareCapital; ShareCapital."User ID")
                {
                }
                column(OpenBalanceShareCap; OpenBalanceShareCap)
                {
                }
                column(ClosingBalanceShareCap; ClosingBalanceShareCap)
                {
                }
                column(ShareCapBF; ShareCapBF)
                {
                }
                column(ShareCapBF2; ShareCapBF2) { }

                trigger OnPreDataItem();
                begin
                    ClosingBalanceShareCap := ShareCapBF;
                    OpenBalanceShareCap := ShareCapBF;
                end;

                trigger OnAfterGetRecord();
                begin
                    ClosingBalanceShareCap := ClosingBalanceShareCap + (ShareCapital.Amount * -1);
                end;

            }
            dataitem(Deposits; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Deposit Contribution"), Reversed = filter(false));
                column(ReportForNavId_1000000036; 1000000036) { } // Autogenerated by ForNav - Do not delete															
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(Customer_No_Dep; Deposits."Customer No.")
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(Amount_Deposits; Deposits.Amount)
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(UserID_Deposits; Deposits."User ID")
                {
                }
                column(OpenBalanceDeposits; OpenBalanceDeposits)
                {
                }
                column(ClosingBalanceDeposits; ClosingBalanceDeposits)
                {
                }
                column(SharesBF; SharesBF)
                {
                }
                column(SharesBF2; SharesBF2) { }
                trigger OnPreDataItem();
                begin
                    ClosingBalanceDeposits := SharesBF;
                    OpenBalanceDeposits := SharesBF;
                end;

                trigger OnAfterGetRecord();
                begin
                    //Message('Here%1',Amount);
                    ClosingBalanceDeposits := ClosingBalanceDeposits + (Deposits.Amount * -1);
                end;

            }


            dataitem(Loans; "Plots Register")
            {
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = sorting(No) where(Posted = const(true));
                column(ReportForNavId_1102755024; 1102755024) { } // Autogenerated by ForNav - Do not delete															
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(Plot_No; Loans."Plot No")
                {
                }
                column(No; loans.No)
                {
                }
                column(Project; Loans.Project)
                {
                }
                column(Projects_Name; Loans."Project Name")
                {
                }

                column(Plot_Amount; Loans."Plot Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Project Name")
                {
                }

                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
                {
                }

                dataitem(loan; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Project Name" = field("Project"), "Plot Number" = field("Plot No");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Plot | "Plot Repayment"), "Entry Type" = filter(<> 'Application'), Reversed = filter(false));
                    column(ReportForNavId_1102755031; 1102755031) { } // Autogenerated by ForNav - Do not delete															
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(Plot_Sale_Document_No; loan."Plot Sale Document No")
                    {
                    }
                    column(Project_Name; loan."Project Name")
                    {
                    }
                    column(Plot_Number; loan."Plot Number")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                        OpeningBalInt := InterestBF;
                        ClosingBalInt := 0;
                    end;

                    trigger OnAfterGetRecord();
                    begin

                        if ((loan."Transaction Type" = loan."transaction type"::Plot) or (loan."Transaction Type" = loan."transaction type"::"Plot Repayment")) then
                            CLosingBalance := CLosingBalance + loan.Amount;
                        if Loans.No = '' then begin
                        end;
                    end;

                }
                trigger OnPreDataItem();
                begin
                    // Loans.SetFilter(Loans."Date filter", Customer.GetFilter(Customer."Date Filter"));
                end;

                trigger OnAfterGetRecord();
                begin
                    /*                     PrincipleBF := 0;
                                        InterestBF := 0;
                                        if LoanSetup.Get(Loans."Loan Product Type") then
                                            LoanName := LoanSetup."Product Description";
                                        if DateFilterBF <> '' then begin
                                            LoansR.Reset;
                                            LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                                            LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                                            if LoansR.Find('-') then begin
                                                LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Outstanding Interest");
                                                PrincipleBF := LoansR."Outstanding Balance";
                                                InterestBF := LoansR."Outstanding Interest";
                                            end;
                                        end; */
                end;

            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(ReportForNavId_1000000042; 1000000042) { } // Autogenerated by ForNav - Do not delete															
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
            end;

            trigger OnAfterGetRecord();
            begin
                // SaccoEmp.Reset;
                // SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                // if SaccoEmp.Find('-') then
                //     EmployerName := SaccoEmp.Description;
                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF1 := '..' + Format(CalcDate('+1D', Customer.GetRangeMax(Customer."Date Filter")));
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                AdditionalSharesBF := 0;
                SilverBF := 0;
                FOSASharesBF := 0;
                JuniorBF := 0;
                SafariBF := 0;
                DependandBF3 := 0;
                InterestOnDepositBF := 0;
                unallocatedBF := 0;
                ShareboostFeeBF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund", Cust."Dividend Amount", Cust."Benevolent Fund", Cust."Un-allocated Funds");
                        SharesBF := (Cust."Current Shares");
                        ShareCapBF := (Cust."Shares Retained");
                        RiskBF := Cust."Insurance Fund";
                        DividendBF := Cust."Dividend Amount";
                        BenfundBF := Cust."Benevolent Fund";

                    end;
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF1);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund", Cust."Dividend Amount", Cust."Benevolent Fund");
                        SharesBF2 := (Cust."Current Shares");
                        ShareCapBF2 := (Cust."Shares Retained");

                    end;
                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
        end;
    }

    trigger OnInitReport()
    begin
        ;

    end;

    trigger OnPostReport()
    begin
        ;
    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        BenfundBF: Decimal;
        FOSASharesBF: Decimal;
        AdditionalSharesBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        DateFilterBF1: Text[150];

        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        //accoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        OpenBalanceShareCap: Decimal;
        ClosingBalanceShareCap: Decimal;
        OpenBalanceDeposits: Decimal;
        ClosingBalanceDeposits: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceJunior: Decimal;
        ClosingBalanceJunior: Decimal;
        OpenBalanceFOSAShares: Decimal;
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceAdditionalShares: Decimal;
        ClosingBalanceAdditionalShares: Decimal;
        JuniorBF: Decimal;
        OpenBalanceSafari: Decimal;
        ClosingBalanceSafari: Decimal;
        ShareCapBF2: Decimal;
        SafariBF: Decimal;
        OpenBalanceSilver: Decimal;
        ClosingBalanceSilver: Decimal;
        SilverBF: Decimal;
        DependandBF3: Decimal;
        InterestOnDepositBF: Decimal;

        closingbalanceDependandBF: Decimal;
        OpeningbalanceDependandBF: Decimal;
        closingbalanceIODBF: Decimal;
        OpeningbalanceIODBF: Decimal;
        SharesBF2: Decimal;
        UnallocatedFunds: Decimal;
        ClosingUnallocated: Decimal;
        OpeningUnallocated: Decimal;
        unallocatedBF: Decimal;

        ShareboostFeeBF: Decimal;
        ClosingBalShareboostFee: Decimal;
        OpemingBalShareBootFee: Decimal;

        ProjectsP: Record Projects;




}



