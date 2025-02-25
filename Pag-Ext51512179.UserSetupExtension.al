//************************************************************************
pageextension 51512179 "UserSetupExtension" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Allow FA Posting From"; Rec."Allow FA Posting From")
            {
                applicationarea = all;

            }
            field("Allow FA Posting To"; Rec."Allow FA Posting To")
            {
                applicationarea = all;

            }
            field("Archiving User"; Rec."Archiving User")
            {
                applicationarea = all;

            }
            field("Is Manager"; Rec."Is Manager")
            {
                applicationarea = all;

            }
            field("Allow Process Payroll"; Rec."Allow Process Payroll")
            {
                applicationarea = all;

            }
            field("Member Registration"; Rec."Member Registration")
            {
                applicationarea = all;

            }

            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                applicationarea = all;

            }
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                applicationarea = all;

            }
            field("Petty C Amount Approval Limit"; Rec."Petty C Amount Approval Limit")
            {
                applicationarea = all;

            }
            field("Post Pv"; Rec."Post Pv") { ApplicationArea = all; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
