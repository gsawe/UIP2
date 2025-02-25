//************************************************************************
codeunit 51510163 "PostCustomerExtension"
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transaction Types Table";
        LoanApp: Record "Loans Register";
        LoanTypes: record "Loan Products Setup";
        CustPostingGroupBuffer: record "Customer Posting Group";
        SaccoSeries: Record "Sacco No. Series";
    begin
        SaccoSeries.Get();
        if cust.Get(GenJournalLine."Account No.") then begin
            if cust.ISNormalMember then begin
                if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                    Error('Cannot post with missing transaction type.');
                TransactionTypestable.reset;
                TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                if TransactionTypestable.Find('-') then begin
                    GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                    GenJournalLine.Modify();
                end else
                    Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
            end;
        end;

        if GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Plot Repayment" then begin
            if GenJournalLine."Plot Number" = 0 then
                Error('Plot No must be specified for Plot Repayment or Plot transactions');
            SaccoSeriess.Get();

            if cust.get(GenJournalLine."Account No.") then
                if Cust.ISNormalMember = true then
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
            Projects.Get(GenJournalLine."Project Name");
            Projects.TestField("Receivables Account");
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin
                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer."Receivables Account" := Projects."Receivables Account";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();

                end;

            end else
                Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        end;

        if GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Commission Paid" then begin
            if GenJournalLine."Plot Number" = 0 then
                Error('Plot No must be specified for Plot Commission or Plot transactions');
            SaccoSeriess.Get();

            if cust.get(GenJournalLine."Account No.") then
                if Cust.ISNormalMember = true then
                    if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                        Error('Cannot post with missing transaction type.');
            Projects.Get(GenJournalLine."Project Name");
            Projects.TestField("Commission Receivable");
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin
                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer."Receivables Account" := Projects."Commission Receivable";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();

                end;

            end else
                Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        end;



        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Plot) then begin
            if GenJournalLine."Plot Number" = 0 then
                Error('Plot No must have a value for  :- %1', GenJournalLine."Account No.");
            SaccoSeriess.Get();
            // Message('pROJECT%1',GenJournalLine."Project Name");
            // Message('firsst%1', Cust.ISNormalMember);
            Projects.Reset();
            Projects.SetRange(Projects.Name, GenJournalLine."Project Name");
            if Projects.FindFirst() then
                Projects.TestField("Receivables Account");
            TransactionTypestable.reset;
            TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
            if TransactionTypestable.Find('-') then begin

                CustPostingGroupBuffer.Reset();
                CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                if CustPostingGroupBuffer.FindFirst() then begin
                    CustPostingGroupBuffer."Receivables Account" := Projects."Receivables Account";
                    CustPostingGroupBuffer.Modify();
                    GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                    GenJournalLine.Modify();

                end else
                    Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

            end;

        end;



    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
    begin

        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Plot Sale Document No" := GenJournalLine."Plot Sale Document No";
        CustLedgerEntry."Loan Type" := GenJournalLine."Loan Product Type";
        CustLedgerEntry."Plot Number" := GenJournalLine."Plot Number";
        CustLedgerEntry."Project Name" := GenJournalLine."Project Name";
        CustLedgerEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        CustLedgerEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        CustLedgerEntry."Transaction Date" := WorkDate();
        CustLedgerEntry."Application Source" := GenJournalLine."Application Source";
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry.CalcFields(Amount);
        CustLedgerEntry."Transaction Amount" := GenJournalLine.Amount;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry2(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No" := GenJournalLine."Loan No";
        DtldCustLedgEntry."Plot Sale Document No" := GenJournalLine."Plot Sale Document No";
        DtldCustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";
        DtldCustLedgEntry."Plot Number" := GenJournalLine."Plot Number";
        DtldCustLedgEntry."Project Name" := GenJournalLine."Project Name";
        DtldCustLedgEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        DtldCustLedgEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        DtldCustLedgEntry."Transaction Date" := WorkDate();
        DtldCustLedgEntry."Application Source" := GenJournalLine."Application Source";
        DtldCustLedgEntry."Created On" := CurrentDateTime;
        DtldCustLedgEntry.Description := GenJournalLine.Description;
        // DtldCustLedgEntry.Insert(true);
        // Message('%1-%2-%3', DtldCustLedgEntry."Transaction Type", DtldCustLedgEntry."Loan No", DtldCustLedgEntry."Transaction Date");

    end;

    [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    procedure modifyreversedCustLedger(Number: Integer)
    var
        Custledger: Record "Cust. Ledger Entry";
        CustledgeentPage: page "Customer Ledger Entries";
        ReversalEntry: Record "Reversal Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        Custledger.reset;
        if Custledger.Findlast then begin
            Custledger.CalcFields(Amount);
            if Custledger.Reversed then
                Custledger."Transaction Amount" := Custledger.amount;
            Custledger.Modify();
        end;
        Custledger.Reset();
        //Custledger.SetRange(Custledger."Entry No.", DetailedCustLedgerEntry."Cust. Ledger Entry No.");
        Custledger.SetRange(Reversed, true);
        if Custledger.FindSet(true) then begin
            repeat
                //Message('here');
                DetailedCustLedgerEntry.Reset();
                DetailedCustLedgerEntry.SetRange(DetailedCustLedgerEntry."Cust. Ledger Entry No.", Custledger."Entry No.");
                if DetailedCustLedgerEntry.FindSet(true, true) then begin
                    DetailedCustLedgerEntry.Reversed := true;
                    DetailedCustLedgerEntry."Reversal Date" := Today;
                    DetailedCustLedgerEntry.Modify(true);
                    //Message('here2');
                end;
            until Custledger.Next = 0;
        end;
    end;

    var
        SaccoSeriess: Record "Sacco No. Series";
        Projects: Record Projects;

}


