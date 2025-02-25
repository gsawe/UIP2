tableextension 50000 "Purchase Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
          field(6603;"Requisition Nos.";Code[20])
        {
            Caption = 'Requisition Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6604;"Mission Proposal Nos.";Code[20])
        {
            Caption = 'Mission Proposal Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6605;"Imprest Nos.";Code[20])
        {
            Caption = 'Imprest Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6606;"Surrender Nos.";Code[20])
        {
            Caption = 'Imprest Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6607;"Line Nos.";Code[20])
        {
            Caption = 'Line Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6608;"Purchase Requisition Template";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(6609;"Purchase Requisition Batch";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name"=FILTER('GENERAL'));
        }
        field(6615;"Receipt Template";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(6616;"Receipting Batch";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name"=FILTER('GENERAL'));
        }
        field(51516370;"Change Nos";Code[20])
        {
            Caption = 'Change Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
       field(51516371;"Title Nos";Code[20])
        {
            Caption = 'TitleNos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(51516372;"Process Nos";Code[20])
        {
            Caption = 'Process Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(51516373;"Reward Nos";Code[20])
        {
            Caption = 'Reward Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    
    var
        myInt: Integer;
} 