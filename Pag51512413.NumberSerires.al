//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512413 "Number Serires"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SMS Request Series"; Rec."SMS Request Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Credit)
            {
                Caption = 'Credit';
                Visible = false;

                field("Micro Loans"; Rec."Micro Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Members Nos"; Rec."Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Loans Nos"; Rec."BOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Nos"; Rec."E-Loan Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Batch Nos"; Rec."Loans Batch Nos")
                {
                    ApplicationArea = Basic;
                }

                field("BOSA Transfer Nos"; Rec."BOSA Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Closure  Nos"; Rec."Closure  Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Transaction Nos"; Rec."Bosa Transaction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Processing"; Rec."Paybill Processing")
                {
                    ApplicationArea = Basic;
                }

                field("Checkoff Proc Block Nos"; Rec."Checkoff Proc Block Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BosaNumber; rec.BosaNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No Used';
                }
                field("Loan PayOff Nos"; Rec."Loan PayOff Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Microfinance Last No Used"; Rec."Microfinance Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("MicroFinance Account Prefix"; Rec."MicroFinance Account Prefix")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Transactions"; Rec."Micro Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Finance Transactions"; Rec."Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Register No"; Rec."Collateral Register No")
                {
                    ApplicationArea = Basic;
                }
                field("Cloudpesa Reg No."; Rec."Cloudpesa Reg No.")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Package Nos"; Rec."Safe Custody Package Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Agent Nos"; Rec."Safe Custody Agent Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Item Nos"; Rec."Safe Custody Item Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Nos"; Rec."Package Retrieval Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Cell Group Nos"; Rec."Member Cell Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("House Change Request No"; Rec."House Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("BD Training Nos"; Rec."BD Training Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Agent/NOK Change"; Rec."Member Agent/NOK Change")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Application"; Rec."House Group Application")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Nos"; Rec."House Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Charge"; Rec."CRB Charge")
                {
                    ApplicationArea = Basic;
                    Caption = 'CRB Check Charge No';
                }
                field("Over Draft Application No"; Rec."Over Draft Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Restructure"; Rec."Loan Restructure")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Movement No"; Rec."Collateral Movement No")
                {
                    ApplicationArea = Basic;
                }
                field("Sweeping Instructions"; Rec."Sweeping Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Employers Nos"; Rec."Employers Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Statements"; Rec."Scheduled Statements")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Document No"; Rec."Payroll Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Audit issue Tracker"; Rec."Audit issue Tracker")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Sub No."; Rec."Guarantor Sub No.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order Members Nos"; Rec."Standing Order Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change Request No"; Rec."Change Request No")
                {
                    ApplicationArea = Basic;
                }
            }

            group("Finance/Others")
            {
                Caption = 'Finance/Others';
                Visible = false;
                field("Finance UpLoads"; Rec."Finance UpLoads")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Requisition No."; Rec."Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Purchase No."; Rec."Internal Purchase No.")
                {
                    ApplicationArea = Basic;
                }
                field("Quatation Request No"; Rec."Quatation Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Stores Requisition No"; Rec."Stores Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Use Procurement limits"; Rec."Use Procurement limits")
                {
                    ApplicationArea = Basic;
                }
                field("Request for Quotation Nos"; Rec."Request for Quotation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investors Nos"; Rec."Investors Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Property Nos"; Rec."Property Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Project Nos"; Rec."Investment Project Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax %"; Rec."Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Account"; Rec."VAT Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Investor)
            {
                Caption = 'Investor';

                field("Member Application Nos"; Rec."Member Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Plots Release"; Rec."Plots Release")
                {
                    ApplicationArea = Basic;
                }

                field("Investor Application Nos"; Rec."Investor Application Nos")
                {
                    ApplicationArea = Basic;
                }

                field("BOSA Receipts Nos"; Rec."BOSA Receipts Nos")
                {
                    Caption = 'Receipt Numbers';
                    ApplicationArea = Basic;
                }
                field("Investor Nos"; Rec."Investor Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill No."; Rec."Paybill No.")
                {
                    ApplicationArea = Basic;
                }

                field("Plots Purchase"; Rec."Plots Purchase")
                {
                    ApplicationArea = Basic;
                }
                field("Plots Receivable"; Rec."Plots Receivable")
                {
                    ApplicationArea = All;
                }
                field("Diligence Nos"; Rec."Diligence Nos")
                {
                    ApplicationArea = All;
                }
                field("Title Nos"; Rec."Title Nos")
                {
                    ApplicationArea = All;
                }
                field("Process Nos"; Rec."Process Nos")
                {
                    ApplicationArea = All;
                }
                field("Checkoff-Proc Distributed Nos"; Rec."Checkoff-Proc Distributed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Nos"; Rec."Employer Nos")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




